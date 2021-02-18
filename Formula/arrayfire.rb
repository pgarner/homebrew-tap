# Copied from homebrew-core with binary compute added
class Arrayfire < Formula
  desc "Accelerated computing library"
  homepage "https://arrayfire.com"
  version "3.8.0"
  url "https://github.com/arrayfire/arrayfire/releases/download/v#{version}/arrayfire-full-#{version}.tar.bz2"
  sha256 "dfc1ba61c87258f9ac92a86784b3444445fc4ef6cd51484acc58181c6487ed9e"
  license "BSD-3-Clause"

  on_macos do
    depends_on "boost" => :build
  end
  depends_on "cmake" => :build
  depends_on "freeimage"
  depends_on "mkl"
  on_linux do
    depends_on "cuda"
    depends_on "cudnn"
  end

  def install
    # Can also specify -DCUDA_architecture_build_targets=3.0;3.5;...
    args = [
      "-DAF_BUILD_CPU=ON",
      "-DAF_BUILD_OPENCL=OFF",
      "-DUSE_CPU_MKL=ON",
      "-DAF_BUILD_EXAMPLES=ON",
      "-DAF_BUILD_DOCS=OFF",
      "-DCMAKE_STRIP=FALSE",
    ]
    on_linux do
      args += [
        "-DAF_BUILD_CUDA=ON",
        "-DAF_WITH_CUDNN=ON",
        # "-DCUDA_HOST_COMPILER=/usr/bin/gcc-8" # CUDA 10.2
      ]
    end

    mkdir "build" do
      system "cmake", "..", *std_cmake_args, *args
      system "make", "install"
    end
    pkgshare.install "examples"
  end

  test do
    cp pkgshare/"examples/helloworld/helloworld.cpp", testpath/"test.cpp"
    system ENV.cxx, "-std=c++11", "test.cpp", "-L#{lib}", "-laf", "-lafcpu", "-o", "test"
    assert_match "ArrayFire v#{version}", shell_output("./test")
  end
end
