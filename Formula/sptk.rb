class Sptk < Formula
  desc "Speech Signal Processing Toolkit"
  homepage "https://github.com/sp-nitech/SPTK"
  version "4.0"
  url "https://github.com/sp-nitech/SPTK/archive/refs/tags/v#{version}.tar.gz"
  sha256 "2defd24b1f0b7e857b046d1bba390bbafddcca517a816de633640cb4b5b9f871"
  license "Apache-2.0"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "cmake", "--build", "."
    system "cmake", "--install", "."
  end

  test do
    system "false"
  end
end
