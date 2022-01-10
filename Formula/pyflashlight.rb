class Pyflashlight < Formula
  desc "Python bindings for Flashlight"
  homepage "https://github.com/facebookresearch/flashlight/tree/master/bindings/python"
  version "0.3.1"
  url "https://github.com/facebookresearch/flashlight.git", tag: "v#{version}"
  license "BSD-3-Clause"

  depends_on "cmake" => :build
  depends_on "python3"
  depends_on "mkl"
  depends_on "kenlm"
  depends_on "pytorch"

  on_linux do
    depends_on "cuda"
  end

  def install
    ENV["VERBOSE"] = "1"
    xy = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH",
      "#{prefix}/lib/python#{xy}/site-packages"
    deps = [
      "packaging"
    ]
    system "pip3", "-v", "install", "--prefix", "#{prefix}", *deps
    cd buildpath/"bindings/python" do
      system "python3", *Language::Python.setup_install_args(prefix)
    end
  end

  test do
    system "false"
  end
end
