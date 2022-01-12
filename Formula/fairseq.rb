class Fairseq < Formula
  desc "A sequence modeling toolkit"
  homepage "https://github.com/pytorch/fairseq"
  version "2021.10"
  url "https://github.com/pytorch/fairseq.git", revision: "dd3bd3c"
  head "https://github.com/pytorch/fairseq"
  license "MIT"

  depends_on "ninja" => :build
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

    # Not necessary if cython is already installed globally
    xy = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH",
      "#{prefix}/lib/python#{xy}/site-packages"

    deps = [
      "cython",
      "editdistance",
      "soundfile",
      "bitarray",
      "tqdm",
      "hydra-core",
      "omegaconf<2.1",
      "regex",
      "sacrebleu"
    ]
    system "pip3", "-v", "install", "--prefix", "#{prefix}", *deps
    system "python3", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "false"
  end
end
