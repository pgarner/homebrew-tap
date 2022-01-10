class Kaldi < Formula
  desc "Kaldi ASR"
  homepage "https://kaldi-asr.org/"
  version "2021.11"
  url "https://github.com/kaldi-asr/kaldi.git", revision: "6e03a3f5"
  head "https://github.com/kaldi-asr/kaldi"
  license "Apache"

  depends_on "sph2pipe"
  depends_on "sctk"
  depends_on "openfst@1.6.7"
  depends_on "mkl"
  on_linux do
    depends_on "cuda"
  end
  on_macos do
    depends_on "wget" # To fetch portaudio
  end

  patch :DATA

  def install
    on_linux do
      cd buildpath/"tools" do
        ln_s Formula["cuda"].include, "cub"
      end
    end
    cd buildpath/"src" do
      confargs = [
        "--fst-root=#{Formula["openfst@1.6.7"].prefix}",
        "--fst-version=1.6.7",
        "--mkl-root=#{Formula["mkl"].prefix}"
        # "--shared", # May break an "install"
      ]
      on_linux do
        confargs << "--cudatk-dir=#{Formula["cuda"].prefix}"
      end
      on_macos do
        confargs << "--use-cuda=no"
      end
      system "bash", "configure", *confargs
      system "make", "depend"
      system "make"
    end

    # This may be overkill, but is easy :-)
    prefix.install "src"
    prefix.install "scripts"
    prefix.install "misc"
    prefix.install "egs"
    prefix.install "tools"

    # Links to make the tools work; they are relative
    cd prefix/"tools" do
      ln_s Formula["sph2pipe"].prefix, "sph2pipe"
      ln_s Formula["sctk"].prefix, "sctk"
      ln_s Formula["openfst@1.6.7"].prefix, "openfst"
    end
  end

  test do
    system "false"
  end
end

__END__
diff --git a/src/configure b/src/configure
index 5f57cdfad..b02d02411 100755
--- a/src/configure
+++ b/src/configure
@@ -319,8 +319,8 @@ Either your CUDA is too new or too old."
           CUSOLVER=true
         ;;
         11_*)
-          MIN_UNSUPPORTED_GCC_VER="10.0"
-          MIN_UNSUPPORTED_GCC_VER_NUM=100000;
+          MIN_UNSUPPORTED_GCC_VER="11.0"
+          MIN_UNSUPPORTED_GCC_VER_NUM=110000;
           CUSOLVER=true
         ;;
         *)
