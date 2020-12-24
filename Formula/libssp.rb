class Libssp < Formula
  desc "Library for speech signal processing"
  homepage "https://github.com/idiap/libssp"
  url "https://github.com/idiap/libssp/archive/v1.0.tar.gz"
  version "1.0"
  sha256 "7efde6de9e7c306344aed764dd73f970e60249703a264b194c784ace1de7ace9"
  license "BSD-3-Clause"

  depends_on "cmake" => :build
  depends_on "lube"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "false"
  end
end
