class Tracter < Formula
  desc "A lightweight dataflow framework"
  homepage "https://github.com/idiap/tracter"
  version "2.0"
  url "https://github.com/idiap/tracter/archive/v#{version}.tar.gz"
  sha256 "e2b53e13f93011ed7d10e4333ebb65ff4d6c065e2eea53f46abace5e7e51abee"
  license "BSD-3-Clause"

  depends_on "cmake" => :build
  depends_on "pgarner/tap/libresample"
  depends_on "lube"
  depends_on "sptk"
  depends_on "libssp"

  def install
    system "sh", "prepare.sh"
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "false"
  end
end
