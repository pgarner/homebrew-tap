class Mxnet < Formula
  desc "Lightweight, Portable, Flexible Distributed/Mobile Deep Learning"
  homepage "https://mxnet.apache.org/"
  version "1.9.0"
  url "https://github.com/apache/incubator-mxnet.git", tag: "#{version}"
  head "https://github.com/apache/incubator-mxnet"
  license "Apache"

  depends_on "cmake" => :build
  depends_on "mkl"
  on_linux do
    depends_on "cuda"
    depends_on "cudnn"
    depends_on "nccl"
  end

  def install
    rm_r "3rdparty/openmp"
    rm_r "3rdparty/nvidia_cub"
    args = [
      "-DUSE_MKLDNN=1",
      "-DUSE_CPP_PACKAGE=1",
      "-DBUILD_CPP_EXAMPLES=0"
    ]
    on_linux do
      args += [
        "-DUSE_CUDA=1",
        "-DUSE_NCCL=1",
        "-DUSE_CUDNN=1",
        "-DMXNET_CUDA_ARCH=3.7 6.1 7.0 7.5 8.6+PTX"
      ]
    end
    on_macos do
      args += [
        # OpenMP and OpenCV could work, they just have a lot of deps
        "-DPYTHON_EXECUTABLE=/usr/bin/python3",
        "-DUSE_CUDA=0",
        "-DUSE_OPENMP=0",
        "-DUSE_OPENCV=0"
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
