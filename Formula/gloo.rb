class Gloo < Formula
  desc "Facebook collective communications library"
  homepage "https://github.com/facebookincubator/gloo"
  url "https://github.com/facebookincubator/gloo.git", revision: "1da2117"
  version "2020.12.03"
  license "BSD"

  depends_on "cmake" => :build
  on_linux do
    depends_on "cuda11"
    depends_on "nccl"
  end

  def install
    args = [
      "-DUSE_MPI=ON",
      "-DCUDA_ARCH_NAME=Volta"
    ]
    on_linux do
      args << "-DUSE_CUDA=ON"
      args << "-DUSE_NCCL=ON"
    end
    system "cmake", ".", *std_cmake_args, *args
    system "make", "install"
  end

  test do
    system "false"
  end
end
