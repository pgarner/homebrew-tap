class Kenlm < Formula
  desc "KenLM Language Model Toolkit"
  homepage "KenLM Language Model Toolkit"
  url "https://kheafield.com/code/kenlm.tar.gz"
  version "2020.10" # Last date in the tar file
  sha256 "0a10fb9612a9f53716bf929231ce16b8cd65c09c34fad23e6d65cf04dff3e47c"
  license "LGPL"

  keg_only "SPTK also installs interpolate"

  depends_on "cmake" => :build
  on_macos do
    depends_on "boost" => :build
  end

  def install
    args = [
      "-DKENLM_MAX_ORDER=20",
      "-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
    ]
    system "cmake", ".", *std_cmake_args, *args
    system "cmake", "--build", "."
    system "cmake", "--install", "."
  end

  test do
    system "false"
  end
end
