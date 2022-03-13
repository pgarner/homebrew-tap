class Nccl < Formula
  desc "NVIDIA Collective Communication Library"
  homepage "https://docs.nvidia.com/deeplearning/nccl/user-guide/docs/index.html"
  version "2.12.7-1"
  url "https://github.com/NVIDIA/nccl/archive/v#{version}.tar.gz"
  head "https://github.com/NVIDIA/nccl.git"
  sha256 "928d02e61637128f53320a89088c9c2e597fe9d25548dfaf06238bf5a87420fd"
  license "NVidia"

  depends_on :linux
  depends_on "cuda"

  def install
    gencode = [
      "-gencode=arch=compute_37,code=sm_37",
      "-gencode=arch=compute_61,code=sm_61",
      "-gencode=arch=compute_70,code=sm_70",
      "-gencode=arch=compute_75,code=sm_75",
      "-gencode=arch=compute_86,code=sm_86",
      "-gencode=arch=compute_86,code=compute_86"
    ].join(" ")
    system "make", "src.build",
           "CUDA_HOME=#{Formula["cuda"].prefix}",
           "NVCC_GENCODE=#{gencode}"

    include.install Dir["build/include/*"]
    lib.install Dir["build/lib/*"]
  end

  test do
    system "false"
  end
end
