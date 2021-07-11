class Flang < Formula
  desc "Ground-up implementation of a Fortran front end written in modern C++"
  homepage "https://github.com/llvm/llvm-project/tree/main/flang"
  version "11.1.0"
  url "https://github.com/llvm/llvm-project/archive/refs/tags/llvmorg-#{version}.tar.gz"
  sha256 "53a0719f3f4b0388013cfffd7b10c7d5682eece1929a9553c722348d1f866e79"
  license "Apache"

  depends_on "cmake" => :build
  depends_on "llvm" => :build

  def install
    cd buildpath/"flang" do
      system "cmake", "-S", ".", "-B", "build", *std_cmake_args
      system "cmake", "--build", "build"
      system "cmake", "--install", "build"
    end
  end

  test do
    system "false"
  end
end
