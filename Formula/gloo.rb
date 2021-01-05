class Gloo < Formula
  desc "Facebook collective communications library"
  homepage "https://github.com/facebookincubator/gloo"
  url "https://github.com/facebookincubator/gloo.git", revision: "1da2117"
  version "2020.12.03"
  license "BSD"

  depends_on "cmake" => :build
  depends_on "cuda@10.2"
  depends_on "gloo"

  def install
    args = [
      "-DUSE_MPI=ON",
      "-DUSE_CUDA=ON",
      "-DUSE_NCCL=ON"
    ]
    system "cmake", ".", *std_cmake_args, *args
    system "make", "install"
  end

  test do
    system "false"
  end
end
