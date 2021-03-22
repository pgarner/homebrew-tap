class Openpose < Formula
  desc "The first real-time multi-person system to jointly detect human body, hand, facial, and foot keypoints"
  homepage "https://cmu-perceptual-computing-lab.github.io/openpose/web/html/doc/"
  version "1.7.0"
  url "https://github.com/CMU-Perceptual-Computing-Lab/openpose.git", tag: "v#{version}"
  license "Openpose"

  depends_on "cmake" => :build
  depends_on "mkl"
  depends_on "pgarner/tap/hdf5"
  depends_on "glog"
  depends_on "gflags"
  depends_on "protobuf"
  depends_on "cuda@11.1"
  depends_on "cudnn@11.1"

  def install
    ENV.cxx11
    args = [
      "-DUSE_MKL=ON",
      "-DCUDA_ARCH=All"
    ]
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "false"
  end
end
