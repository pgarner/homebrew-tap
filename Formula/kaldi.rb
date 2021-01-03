class Kaldi < Formula
  desc "Kaldi ASR"
  homepage "https://kaldi-asr.org/"
  version "2020.07.06"
  url "https://github.com/kaldi-asr/kaldi.git", revision: "794732a"
  head "https://github.com/kaldi-asr/kaldi"
  license "Apache"

  depends_on "openfst@1.6.7"
  depends_on "mkl"
  on_linux do
    depends_on "cuda@10.2"
  end

  def install
    cd buildpath/"tools" do
      system "make", "cub"
    end
    cd buildpath/"src" do
      confargs = [
        "--fst-root=#{Formula["openfst@1.6.7"].prefix}",
        "--fst-version=1.6.7",
        "--mkl-root=#{HOMEBREW_PREFIX}"
        # "--shared", # May break an "install"
      ]
      on_linux do
        # CUDA 10.2 requires gcc-8
        confargs << "--cudatk-dir=#{Formula["cuda@10.2"].prefix}"
        ENV["CC"] = "gcc-8"
        ENV["CXX"] = "g++-8"
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
  end

  test do
    system "false"
  end
end
