class Fairseq < Formula
  desc "A sequence modeling toolkit"
  homepage "https://github.com/pytorch/fairseq"
  version "0.10.2"
  url "https://github.com/pytorch/fairseq.git", tag: "v#{version}"
  license "MIT"

  depends_on "pytorch"

  on_macos do
    uses_from_macos "python@3"
  end

  on_linux do
    depends_on "nccl"
  end

  def install
    system "pip3", "-v", "install", "--prefix", "#{prefix}", "."
  end

  test do
    system "false"
  end
end
