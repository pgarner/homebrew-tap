class Sptk < Formula
  desc "Speech Signal Processing Toolkit"
  homepage "http://sp-tk.sourceforge.net"
  url "http://downloads.sourceforge.net/sp-tk/SPTK-3.11.tar.gz"
  version "3.11"
  sha256 "ae26929a3c196ca8a1d1a638718fc4400adf8ce963b8328be72f8802f1589100"
  license "Modified-BSD"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "false"
  end
end
