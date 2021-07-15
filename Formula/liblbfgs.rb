class Liblbfgs < Formula
  desc "C library of limited-memory BFGS (L-BFGS)"
  homepage "http://www.chokkan.org/software/liblbfgs/"
  url "https://github.com/chokkan/liblbfgs.git"
  version "2021-04"
  license "MIT"

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
