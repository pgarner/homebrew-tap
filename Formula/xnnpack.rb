class Xnnpack < Formula
  desc "Floating-point neural network inference operators"
  homepage "https://github.com/google/XNNPACK"
  version "2021.11"
  url "https://github.com/google/XNNPACK.git", revision: "15eec02"
  license "BSD-3-Clause"

  depends_on "cmake" => :build

  def install
    args = [
      # The last two prevent it *installing* googletest and clashing
      "-DCMAKE_POSITION_INDEPENDENT_CODE=1",
      "-DXNNPACK_BUILD_TESTS=0",
      "-DXNNPACK_BUILD_BENCHMARKS=0"
    ]
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "false"
  end
end
