class Onnx < Formula
  desc "Open Neural Network Exchange"
  homepage "https://onnx.ai/"
  version "1.11.0"
  url "https://github.com/onnx/onnx.git", tag: "v#{version}"
  head "https://github.com/onnx/onnx.git"
  license "Apache-2.0"

  depends_on "python3"
  depends_on "pybind11"
  depends_on "pgarner/tap/numpy"
  depends_on "protobuf"
  depends_on "six"

  def install
    ENV["CMAKE_ARGS"] = "-DONNX_USE_LITE_PROTO=ON"
    system "python3", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "false"
  end
end
