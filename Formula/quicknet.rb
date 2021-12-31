class Quicknet < Formula
  desc "ICSI's MLP implementation"
  homepage "http://www1.icsi.berkeley.edu/Speech/qn.html"
  version "3.33"
  url "ftp://ftp.icsi.berkeley.edu/pub/real/davidj/quicknet-v#{version.major}_#{version.minor}.tar.gz"
  sha256 "035003767e1d7580ae30bdf3c4ff839a9b380e239d4b2ecde85df55d94f9a145"
  license "BSD (probably)"

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
    ]
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "false"
  end
end
