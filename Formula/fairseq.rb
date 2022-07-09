class Fairseq < Formula
  desc "A sequence modeling toolkit"
  homepage "https://github.com/pytorch/fairseq"
  version "0.12.2"
  url "https://github.com/pytorch/fairseq.git", tag: "v#{version}"
  head "https://github.com/pytorch/fairseq.git"
  license "MIT"

  on_macos do
    depends_on "ninja"  => :build
  end
  depends_on "python3"
  depends_on "pgarner/tap/numpy"

  if Formula["cuda"].optlinked? then
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
