class Flashlight < Formula
  desc "Fast, Flexible Machine Learning in C++"
  homepage "https://github.com/facebookresearch/flashlight"
  url "https://github.com/facebookresearch/flashlight.git", revision: "8c8bf48"
  version "2021.01.05"
  license "BSD"

  depends_on "cmake" => :build
  depends_on "arrayfire-bc"
  depends_on "gloo"
  depends_on "glog"
  depends_on "open-mpi"
  on_linux do
    depends_on "nccl"
  end

  def install
    args = []
    on_linux do
      args << "-DCUDA_HOST_COMPILER=/usr/bin/gcc-8"
    end
    on_macos do
      args << "-DFL_BACKEND=CPU"
    end
    system "cmake", ".", *std_cmake_args, *args
    system "make", "install"
  end

  test do
    system "false"
  end
end
