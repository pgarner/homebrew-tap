class Magma < Formula
  desc "Matrix Algebra on GPU and Multicore Architectures"
  homepage "https://icl.utk.edu/magma/index.html"
  version "2.5.4"
  url "http://icl.utk.edu/projectsfiles/magma/downloads/magma-#{version}.tar.gz"
  sha256 "7734fb417ae0c367b418dea15096aef2e278a423e527c615aab47f0683683b67"
  license "BSD"

  # Magma actually requires *both* a CPU and GPU, hence cuda (or the AMD
  # equivalent); so not MacOS for the moment

  depends_on :linux
  depends_on "cmake" => :build
  depends_on "mkl"
  depends_on "cuda11"

  def install
    ENV["MKLROOT"] = "#{HOMEBREW_PREFIX}"
    args = [
      # We actually want: 3.7;6.1;7.0;7.5;8.6+PTX
      "-DGPU_TARGET=sm_35 sm_61 sm_70 sm_75 sm_80"
    ]
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "false"
  end
end
