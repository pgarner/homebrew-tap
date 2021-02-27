class Ssp < Formula
  desc "Speech Signal Processing module"
  homepage "https://github.com/idiap/ssp"
  url "https://github.com/idiap/ssp.git", revision: "3949632"
  version "2018.08"
  license "BSD-3-Clause"

  on_macos do
    uses_from_macos "python@3"
  end

  def install
    # system "python3", "setup.py", "install",
    # "--prefix=#{prefix}",
    # "--single-version-externally-managed",
    # "--record=installed.txt"
    system "pip3", "-v", "install", "--prefix", "#{prefix}", "."
  end

  test do
    system "false"
  end
end
