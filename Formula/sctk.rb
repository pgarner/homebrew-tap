class Sctk < Formula
  desc "The NIST Scoring Toolkit"
  homepage "https://www.nist.gov/itl/iad/mig/tools"
  license "NIST"
  version "2.4.11"
  head "https://github.com/usnistgov/SCTK.git"
  url "https://github.com/usnistgov/SCTK/archive/master.zip"
  sha256 "40fd0efb9bc1bf8bb7a899bc7425fc9c3a9cd17cf9b71c0f71cfb210b6c10733"

  def install
    system "make", "PREFIX=#{prefix}", "config"
    system "make", "all"
    system "make", "INSTALL=install -D", "install"
  end

  test do
    system "false"
  end
end
