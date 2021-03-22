class Apex < Formula
  desc "Utilities to streamline mixed precision and distributed training"
  homepage "https://nvidia.github.io/apex/"
  url "https://github.com/NVIDIA/apex.git", revision: "e2083df"
  version "2021.02"
  license "BSD-3-Clause"

  on_macos do
    uses_from_macos "python@3"
  end

  depends_on "cuda@11.1"
  depends_on "pytorch"

  def install
    xy = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH",
      "#{HOMEBREW_PREFIX}/lib/python#{xy}/site-packages"
    ENV["TORCH_CUDA_ARCH_LIST"] = "3.5;3.7;6.1;7.0;7.5;8.6+PTX"
    args = %W[
      -v
      --prefix #{prefix}
      --disable-pip-version-check
      --no-cache-dir
      --global-option=--cpp_ext
      --global-option=--cuda_ext
      .
    ]
    system "pip3", "install", *args
  end

  test do
    system "false"
  end
end
