class Onnx < Formula
  desc "Open Neural Network Exchange"
  homepage "https://onnx.ai/"
  version "1.10.2"
  url "https://github.com/onnx/onnx.git", tag: "v#{version}"
  license "Apache-2.0"

  on_macos do
    uses_from_macos "python@3"
  end

  def install
    # Find the things that pip installs as deps before they get linked
    xy = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH",
      "#{prefix}/lib/python#{xy}/site-packages"

    system "pip3", "-v", "install", "--prefix", "#{prefix}", "."
  end

  test do
    system "false"
  end
end
