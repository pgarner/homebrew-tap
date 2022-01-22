class Ctcdecode < Formula
  desc "CTC beam search decoding for PyTorch"
  homepage "https://github.com/parlance/ctcdecode"
  version "1.0.2"
  url "https://github.com/parlance/ctcdecode.git", tag: version
  head "https://github.com/parlance/ctcdecode.git"
  license "MIT"

  depends_on "python3"
  depends_on "pytorch"

  def install
    ENV["VERBOSE"] = "1"
    system "python3", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "false"
  end
end
