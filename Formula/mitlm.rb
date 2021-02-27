class Mitlm < Formula
  desc "MIT Language Modeling Toolkit"
  homepage "https://github.com/mitlm/mitlm"
  version "2018.01"
  url "https://github.com/mitlm/mitlm.git", revision: "553edca"
  license "MIT"

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
