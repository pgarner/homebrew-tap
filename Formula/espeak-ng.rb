class EspeakNg < Formula
  desc "eSpeak NG Text-to-Speech"
  homepage "https://github.com/espeak-ng/espeak-ng"
  url "https://github.com/espeak-ng/espeak-ng.git", tag: version
  version "1.51"
  license "GPL-3.0"

  def install
    system "./autogen.sh"
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make", "install"
  end

  test do
    system "false"
  end
end
