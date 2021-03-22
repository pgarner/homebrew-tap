class Magma < Formula
  desc "Matrix Algebra on GPU and Multicore Architectures"
  homepage "https://icl.utk.edu/magma/index.html"
  version "2.5.4"
  url "http://icl.utk.edu/projectsfiles/magma/downloads/magma-#{version}.tar.gz"
  sha256 "7734fb417ae0c367b418dea15096aef2e278a423e527c615aab47f0683683b67"
  license "BSD"

  depends_on "cmake" => :build
  depends_on "mkl"
  on_linux do
    depends_on "cuda@11.1"
  end

  def install
    ENV["MKLROOT"] = "#{HOMEBREW_PREFIX}"
    mkdir "build" do
      args = [
        # CUDA 11 actually supports 3.5 upwards, but not 3.0
        "-DGPU_TARGET=Maxwell Pascal Volta Turing Ampere"
      ]
      system "cmake", "..", *args, *std_cmake_args
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end
