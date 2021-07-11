class Mitlm < Formula
  desc "MIT Language Modeling Toolkit"
  homepage "https://github.com/mitlm/mitlm"
  version "2018.01"
  url "https://github.com/mitlm/mitlm.git", revision: "553edca"
  license "MIT"

  on_macos do
    depends_on "libtool"
    depends_on "automake"
    depends_on "autoconf"
  end

  def install
    system "autoreconf", "-i"
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
