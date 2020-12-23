class Lube < Formula
  desc "Lubricates the wheels of C++"
  homepage "https://github.com/pgarner/libube"
  url "https://github.com/pgarner/libube/archive/v1.0.tar.gz"
  version "1.0"
  sha256 "e4f94286810ba54f3fd259ac28e6ff16b87a9cca92424b24a6a91f1a2b386d66"
  license "BSD-3-Clause"

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "libsndfile"
  depends_on "expat"
  depends_on "curl"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "false"
  end
end
