class Xnnpack < Formula
  desc "Floating-point neural network inference operators"
  homepage "https://github.com/google/XNNPACK"
  version "2021.03"
  url "https://github.com/google/XNNPACK.git", revision: "09c0591"
  license "BSD-3-Clause"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "false"
  end
end
