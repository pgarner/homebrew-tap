class Pytorch < Formula
  desc "Tensor and DNN library"
  homepage "https://pytorch.org/"
  version "1.8.0"
  url "https://github.com/pytorch/pytorch.git", tag: "v#{version}"
  license "BSD-3-Clause"

  depends_on "cmake" => :build
  depends_on "mkl"
  depends_on "magma"
#  depends_on "gflags"   # But not found
#  depends_on "glog"     # But not found
#  depends_on "protobuf" # But not found
#  depends_on "onednn"   # Found, but builds custom

  on_macos do
    uses_from_macos "python@3"
  end

  on_linux do
    depends_on "cuda@11.1"
    depends_on "cudnn@11.1"
#    depends_on "nccl"   # Found, but builds custom
#    depends_on "gloo"   # Found, but builds custom
  end

  def install
    xy = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH",
      "#{prefix}/lib/python#{xy}/site-packages"
    ENV["INTEL_MKL_DIR"] = "#{HOMEBREW_PREFIX}"
    ENV["CUDNN_LIB_DIR"] = Formula["cudnn@11.1"].lib
    ENV["CUDNN_INCLUDE_DIR"] = Formula["cudnn@11.1"].include
    ENV["TORCH_CUDA_ARCH_LIST"] = "3.5;3.7;6.1;7.0;7.5;8.6+PTX"
#    ENV["NCCL_LIB_DIR"] = Formula["nccl"].lib
#    ENV["NCCL_INCLUDE_DIR"] = Formula["nccl"].include
    system "pip3", "-v", "install", "--prefix", "#{prefix}", "."
  end

  test do
    system "false"
  end
end
