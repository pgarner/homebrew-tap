class Pytorch < Formula
  desc "Tensor and DNN library"
  homepage "https://pytorch.org/"
  version "1.7.1"
  url "https://github.com/pytorch/pytorch.git", tag: "v#{version}"
  license "BSD-3-Clause"

  depends_on "cmake" => :build
  depends_on "mkl"
  depends_on "magma"
  depends_on "glog"
  depends_on "protobuf"

  ENV["BUILD_CUSTOM_PROTOBUF"] = "OFF"

  on_macos do
    uses_from_macos "python@3"
  end

  on_linux do
    depends_on "cuda"
    depends_on "cudnn"
    depends_on "nccl"
    depends_on "gloo"
    #ENV["HOMEBREW_CC"] = "gcc-8"
    #ENV["HOMEBREW_CXX"] = "g++-8"
    ENV["CUDNN_LIB_DIR"] = Formula["cudnn"].lib
    ENV["CUDNN_INCLUDE_DIR"] = Formula["cudnn"].include
  end

  def install
    ENV["CMAKE_PREFIX_PATH"] = prefix
    system "python3", "setup.py", "install", "--prefix=#{prefix}",
           "--single-version-externally-managed", "--record=installed.txt"
  end

  test do
    system "false"
  end
end
