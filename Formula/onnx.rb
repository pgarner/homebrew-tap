class Onnx < Formula
  desc "Open Neural Network Exchange"
  homepage "https://onnx.ai/"
  version "1.10.2"
  url "https://github.com/onnx/onnx.git", tag: "v#{version}"
  license "Apache-2.0"

  depends_on "python3"
  depends_on "pybind11"
  depends_on "pgarner/tap/numpy"
  depends_on "protobuf"
  depends_on "six"

  def install
    ENV["CMAKE_ARGS"] = "-DONNX_USE_PROTOBUF_SHARED_LIBS=ON"
    system "pip3", "-v", "install", "--prefix", "#{prefix}", "."
  end

  test do
    system "false"
  end
end
