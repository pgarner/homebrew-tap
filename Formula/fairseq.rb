class Fairseq < Formula
  desc "A sequence modeling toolkit"
  homepage "https://github.com/pytorch/fairseq"
  version "2021.10"
  url "https://github.com/pytorch/fairseq.git", revision: "dd3bd3c"
  head "https://github.com/pytorch/fairseq"
  license "MIT"

  depends_on "python3"
  depends_on "pgarner/tap/numpy"
  depends_on "pytorch"

  on_linux do
    depends_on "cuda"
    depends_on "nccl"
  end

  conflicts_with "espresso", because: "espresso has fairseq embedded"

  def install
    ENV["VERBOSE"] = "1"
    deps = [
      "editdistance",
      "soundfile"
    ]
    system "pip3", "-v", "install", "--prefix", "#{prefix}", *deps
    system "python3", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "false"
  end
end
