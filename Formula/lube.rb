class Lube < Formula
  desc "Lubricates the wheels of C++"
  homepage "https://github.com/pgarner/libube"
  url "https://github.com/pgarner/libube/archive/v1.0.1.tar.gz"
  head "https://github.com/pgarner/libube.git"
  version "1.0.1"
  sha256 "f6638b7a12501a5c3431be26f84ab55837bbfcd276aa61c4c2bb03f8674d486b"
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
