class Mxnet < Formula
  desc "Lightweight, Portable, Flexible Distributed/Mobile Deep Learning"
  homepage "https://mxnet.apache.org/"
  version "1.8.0"
  url "https://github.com/apache/incubator-mxnet.git", tag: "#{version}"
  head "https://github.com/apache/incubator-mxnet"
  license "Apache"

  depends_on "cmake" => :build
  depends_on "mkl"
  #  depends_on "onednn" # Uses its own
  on_linux do
    depends_on "cuda11"
    depends_on "cudnn11"
    depends_on "nccl"
  end

  def install
    ENV.cxx14
    args = [
      "-DUSE_MKLDNN=1",
      "-DUSE_CPP_PACKAGE=1"
    ]
    on_linux do
      args += [
        "-DUSE_CUDA=1",
        "-DUSE_NCCL=1",
        "-DUSE_CUDNN=1",
        "-DMXNET_CUDA_ARCH=3.7 6.1 7.0 7.5 8.6+PTX"
      ]
    end
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "false"
  end
end
