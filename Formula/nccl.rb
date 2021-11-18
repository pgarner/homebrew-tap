class Nccl < Formula
  desc "NVIDIA Collective Communication Library"
  homepage "https://docs.nvidia.com/deeplearning/nccl/user-guide/docs/index.html"
  version "2.11.4-1"
  url "https://github.com/NVIDIA/nccl/archive/v#{version}.tar.gz"
  head "https://github.com/NVIDIA/nccl"
  sha256 "db4e9a0277a64f9a31ea9b5eea22e63f10faaed36dded4587bbc8a0d8eceed10"
  license "NVidia"

  depends_on :linux
  depends_on "cuda11"

  def install
    gencode = [
      "-gencode=arch=compute_35,code=sm_35",
      "-gencode=arch=compute_61,code=sm_61",
      "-gencode=arch=compute_70,code=sm_70",
      "-gencode=arch=compute_80,code=sm_80",
      "-gencode=arch=compute_80,code=compute_80"
    ].join(" ")
    system "make", "src.build",
           "CUDA_HOME=#{Formula["cuda11"].prefix}",
           "NVCC_GENCODE=#{gencode}"

    include.install Dir["build/include/*"]
    lib.install Dir["build/lib/*"]
  end

  test do
    system "false"
  end
end
