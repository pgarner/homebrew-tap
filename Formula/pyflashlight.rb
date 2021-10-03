class Pyflashlight < Formula
  desc "Python bindings for Flashlight"
  homepage "https://github.com/facebookresearch/flashlight/tree/master/bindings/python"
  version "0.3"
  url "https://github.com/facebookresearch/flashlight.git", tag: "v#{version}"
  license "BSD-3-Clause"

  depends_on "cmake" => :build
  depends_on "mkl"
  depends_on "kenlm"

  on_macos do
    uses_from_macos "python@3"
  end

  on_linux do
    depends_on "cuda11"
    depends_on "sys-python"
  end

  def install
    # The things that pip installs as deps
    xy = Language::Python.major_minor_version("python3")
    ENV.prepend_create_path "PYTHONPATH",
      "#{prefix}/lib/python#{xy}/site-packages"
    ENV["VERBOSE"] = "1"
    cd buildpath/"bindings/python" do
      #system "pip3", "-v", "install", "--prefix", "#{prefix}", "-e", "."
      system "python3", *Language::Python.setup_install_args(prefix)
    end
  end

  test do
    system "false"
  end
end
