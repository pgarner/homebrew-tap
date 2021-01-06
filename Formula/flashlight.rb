class Flashlight < Formula
  desc "Fast, Flexible Machine Learning in C++"
  homepage "https://github.com/facebookresearch/flashlight"
  url "https://github.com/facebookresearch/flashlight.git", revision: "8c8bf48"
  version "2021.01.05"
  license "BSD"

  depends_on "cmake" => :build
  depends_on "arrayfire-bc"
  depends_on "nccl"
  depends_on "gloo"
  depends_on "glog"

  def install
    args = [
      "-DFL_BACKEND=CUDA",
      "-DNCCL_ROOR_DIR=#{HOMEBREW_PREFIX}",
      "-DCUDA_HOST_COMPILER=/usr/bin/gcc-8"
    ]
    system "cmake", ".", *std_cmake_args, *args
    system "make", "install"
  end

  test do
    system "false"
  end
end
