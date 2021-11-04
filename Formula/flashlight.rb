class Flashlight < Formula
  desc "Fast, Flexible Machine Learning in C++"
  homepage "https://github.com/facebookresearch/flashlight"
  version "0.3"
  url "https://github.com/facebookresearch/flashlight.git", tag: "v#{version}"
  license "BSD"

  depends_on "cmake" => :build
  depends_on "pgarner/tap/arrayfire"
  depends_on "gloo"
  depends_on "glog"
  depends_on "cereal"
  # depends_on "googletest" # Seems happier with its own version
  depends_on "kenlm"

  on_linux do
    depends_on "nccl"
  end

  def install
    ENV["VERBOSE"] = "1"
    ENV["KENLM_ROOT"] = Formula["kenlm"].prefix
    args = []
    on_linux do
      args += [
        "-DFL_BACKEND=CUDA",
        "-DFL_BUILD_APP_ASR=ON",
        "-DCUDA_ARCH_LIST=3.7;6.1;7.0;7.5;8.6+PTX"
      ]
    end
    on_macos do
      args << "-DFL_BACKEND=CPU"
    end
    system "cmake", ".", *std_cmake_args, *args
    system "cmake", "--build", "."
    system "cmake", "--install", "."
  end

  test do
    system "false"
  end
end
