class Eximp < Formula
  desc "EXIF based photo importer"
  homepage "https://github.com/pgarner/eximp"
  version "1.0.1"
  url "https://github.com/pgarner/eximp.git", tag: "v#{version}"
  head "https://github.com/pgarner/eximp.git"
  license "BSD-3-Clause"

  depends_on "cmake" => :build
  depends_on "lube"
  on_macos do
    depends_on "libexif"
    # Also libheif, but it has lots of deps
  end

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "false"
  end
end
