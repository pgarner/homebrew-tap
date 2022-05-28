class Apex < Formula
  desc "Utilities to streamline mixed precision and distributed training"
  homepage "https://nvidia.github.io/apex/"
  url "https://github.com/NVIDIA/apex.git", revision: "ab5fc48"
  version "2022.05"
  license "BSD-3-Clause"

  depends_on "cuda"
  depends_on "pytorch"

  def install
    ENV["TORCH_CUDA_ARCH_LIST"] = "3.5;3.7;6.1;7.0;7.5;8.6+PTX"
    args = %W[
      -v
      --prefix #{prefix}
      --disable-pip-version-check
      --no-cache-dir
      --global-option=--cpp_ext
      --global-option=--cuda_ext
    ]
    system "pip3", "install", *args, "."
  end

  test do
    system "false"
  end
end
