class Srilm < Formula
  desc "The SRI Language Modeling Toolkit"
  homepage "http://www.speech.sri.com/projects/srilm"
  version "1.7.3"
  url "file:#{HOMEBREW_LIBRARY}/Taps/pgarner/homebrew-tap/cache/srilm-#{version}.tar.gz"
  sha256 "01eaf12d0f35b96d2b28ad0d41c9f915dd22b534a7abde3fbb9e35fb6c19200e"
  license "SRILM Research Community License"

  depends_on "liblbfgs"

  def install
    system "make", "SRILM=#{buildpath}", "HAVE_LIBLBFGS=1"
    bin.install Dir["bin/*"]
    man1.install Dir["man/man1/*"]
  end

  test do
    system "false"
  end
end
