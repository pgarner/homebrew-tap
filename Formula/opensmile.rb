class Opensmile < Formula
  desc "The Munich Open-Source Large-Scale Multimedia Feature Extractor"
  homepage "https://audeering.github.io/opensmile/"
  url "https://github.com/audeering/opensmile/archive/refs/tags/v3.0.0.tar.gz"
  sha256 "0f7a91276a647c4558211b7a635b8aa41f2418f84b603e76c9b363f848cbbb73"
  license "audEERING"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "false"
  end
end
