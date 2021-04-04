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
    depends_on "cuda11"
    depends_on "cudnn11"
  end

  def install
    args = [
      "-DAF_BUILD_CPU=ON",
      "-DAF_BUILD_OPENCL=ON",
      "-DUSE_CPU_MKL=ON",
      "-DUSE_OPENCL_MKL=ON",
      "-DAF_BUILD_EXAMPLES=ON",
      "-DCMAKE_STRIP=FALSE",
      "-DAF_BUILD_DOCS=OFF"
    ]
    on_linux do
      args += [
        "-DAF_BUILD_CUDA=ON",
        "-DAF_WITH_CUDNN=ON",
        "-DCUDA_architecture_build_targets=3.7;6.1;7.0;7.5;8.6+PTX"
      ]
    end
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    pkgshare.install "examples"
  end

  test do
    cp pkgshare/"examples/helloworld/helloworld.cpp", testpath/"test.cpp"
    system ENV.cxx, "-std=c++11", "test.cpp", "-L#{lib}", "-laf", "-lafcpu", "-o", "test"
    assert_match "ArrayFire v#{version}", shell_output("./test")
  end
end
