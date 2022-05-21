class Pytorch < Formula
  desc "Tensor and DNN library"
  homepage "https://pytorch.org/"
  version "1.11.0"
  url "https://github.com/pytorch/pytorch.git", tag: "v#{version}"
  license "BSD-3-Clause"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "python3"
  depends_on "pgarner/tap/numpy"
  depends_on "mkl"
  depends_on "xnnpack"
  depends_on "protobuf"
  depends_on "pybind11"

  on_linux do
    depends_on "cuda"
    depends_on "cudnn"
    depends_on "nccl"
    depends_on "gloo"
    depends_on "magma"
  end

  def install
    # Inhibit some things
    ENV["BUILD_TEST"] = "0"

    # Try to use the system version of some things (see CMakeLists.txt)
    ENV["USE_SYSTEM_NCCL"] = "1"
    ENV["USE_SYSTEM_GLOO"] = "1"
    ENV["USE_SYSTEM_EIGEN_INSTALL"] = "1"
    ENV["USE_SYSTEM_XNNPACK"] = "1"
    ENV["BUILD_CUSTOM_PROTOBUF"] = "0"
    ENV["USE_SYSTEM_PYBIND11"] = "1"

    # Find the things that pip installs as deps before they get linked
    xy = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH",
      "#{prefix}/lib/python#{xy}/site-packages"

    # Some clues about core libraries
    ENV["INTEL_MKL_DIR"] = "#{HOMEBREW_PREFIX}"
    ENV["CUDNN_LIB_DIR"] = Formula["cudnn"].lib
    ENV["CUDNN_INCLUDE_DIR"] = Formula["cudnn"].include
    ENV["TORCH_CUDA_ARCH_LIST"] = "3.7;6.1;7.0;7.5;8.6+PTX"
    ENV["NCCL_LIB_DIR"] = Formula["nccl"].lib
    ENV["NCCL_INCLUDE_DIR"] = Formula["nccl"].include

    deps = [
      "pyyaml",
      "typing_extensions"
    ]
    system "pip3", "-v", "install", "--prefix", "#{prefix}", *deps
    system "python3", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "false"
  end
end
