class Kenlm < Formula
  desc "KenLM Language Model Toolkit"
  homepage "https://kheafield.com/code/kenlm/"
  url "https://kheafield.com/code/kenlm.tar.gz"
  version "2022.02" # Last date in the tar file
  sha256 "6bb66b6c17f6d23907bd6258ee585328b3e5f5f2b201d41c5f6bd0c390c2c913"
  license "LGPL"

  depends_on "cmake" => :build
  on_macos do
    depends_on "boost" => :build
  end

  def install
    args = [
#      "-DKENLM_MAX_ORDER=20",
#      "-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
    ]
    system "cmake", ".", *std_cmake_args, *args
    system "cmake", "--build", "."
    system "cmake", "--install", "."
  end

  test do
    system "false"
  end
end
