class Torchaudio < Formula
  desc "An audio library for PyTorch"
  homepage "https://pytorch.org/audio/stable/index.html"
  version "0.10.0"
  url "https://github.com/pytorch/audio.git", tag: "v#{version}"
  head "https://github.com/pytorch/audio.git"
  license "BSD-2-Clause"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "pytorch"

  on_linux do
    depends_on "cuda"
    depends_on "cudnn"
  end

  def install
    ENV["USE_OPENMP"] = "ON"
    on_linux do
      ENV["USE_CUDA"] = "ON"
      ENV["TORCH_CUDA_ARCH_LIST"] = "3.7;6.1;7.0;7.5;8.6+PTX"
    end

    system "python3", *Language::Python.setup_install_args(prefix)    
  end

  test do
    system "false"
  end
end
