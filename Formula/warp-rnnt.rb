class WarpRnnt < Formula
  desc "CUDA-Warp RNN-Transducer"
  homepage "https://github.com/1ytic/warp-rnnt"
  version "2021-08"
  url "https://github.com/1ytic/warp-rnnt.git", revision: "e52083e"
  license "MIT"

  depends_on "python3"
  depends_on "pytorch"

  def install
    ENV["VERBOSE"] = "1"
    cd "pytorch_binding" do
      system "python3", *Language::Python.setup_install_args(prefix)
    end
  end

  test do
    system "false"
  end
end
