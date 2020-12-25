class Lube < Formula
  desc "Lubricates the wheels of C++"
  homepage "https://github.com/pgarner/libube"
  url "https://github.com/pgarner/libube/archive/v1.0.tar.gz"
  head "https://github.com/pgarner/libube.git"
  version "1.0"
  sha256 "e4f94286810ba54f3fd259ac28e6ff16b87a9cca92424b24a6a91f1a2b386d66"
  license "BSD-3-Clause"

  on_macos do
    depends_on "boost"
  end

  depends_on "cmake" => :build
  depends_on "libsndfile"

  *opts = %w(
  )

  def install
    system "cmake", ".",
           "-DCMAKE_DISABLE_FIND_PACKAGE_Qwt=TRUE",
           *std_cmake_args
    system "make", "install"
  end

  test do
    system "false"
  end
end
