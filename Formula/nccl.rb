class Nccl < Formula
  desc "NVIDIA Collective Communication Library"
  homepage "https://docs.nvidia.com/deeplearning/nccl/user-guide/docs/index.html"
  version "2.8.3-1"
  url "https://github.com/NVIDIA/nccl/archive/v#{version}.tar.gz"
  head "https://github.com/NVIDIA/nccl"
  sha256 "3ae89ddb2956fff081e406a94ff54ae5e52359f5d645ce977c7eba09b3b782e6"
  license "NVidia"

  depends_on :linux
  depends_on "cuda"

  def install
    system "make", "src.build", "CUDA_HOME=#{Formula["cuda"].prefix}"

    include.install Dir["build/include/*"]
    lib.install Dir["build/lib/*"]
  end

  test do
    system "false"
  end
end
