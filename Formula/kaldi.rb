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

  def install
    on_linux do
      cd buildpath/"tools" do
        system "make", "cub"
      end
    end
    cd buildpath/"src" do
      confargs = [
        "--fst-root=#{Formula["openfst@1.6.7"].prefix}",
        "--fst-version=1.6.7",
        "--mkl-root=#{HOMEBREW_PREFIX}"
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
