class Pytorch < Formula
  desc "Tensor and DNN library"
  homepage "https://pytorch.org/"
  version "1.7.1"
  url "https://github.com/pytorch/pytorch.git", tag: "v#{version}"
  license "BSD-3-Clause"

  depends_on "cmake" => :build
  depends_on "mkl"
  depends_on "magma"
  depends_on "gflags"   # But not found
  depends_on "glog"     # But not found
  depends_on "protobuf" # But not found
  depends_on "onednn"   # Found, but builds custom

  on_macos do
    uses_from_macos "python@3"
  end

  on_linux do
    depends_on "cuda"
    depends_on "cudnn"
    depends_on "nccl"   # Found, but builds custom
    depends_on "gloo"   # Found, but builds custom
  end

  def install
    ENV["INTEL_MKL_DIR"] = "#{HOMEBREW_PREFIX}"
    ENV["CUDNN_LIB_DIR"] = Formula["cudnn"].lib
    ENV["CUDNN_INCLUDE_DIR"] = Formula["cudnn"].include
    ENV["NCCL_LIB_DIR"] = Formula["nccl"].lib
    ENV["NCCL_INCLUDE_DIR"] = Formula["nccl"].include
    system "pip3", "-v", "install", "-t", "#{prefix}", "."
  end

  test do
    system "false"
  end
end
