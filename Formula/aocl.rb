class Aocl < Formula
  desc "AMD Optimizing CPU Libraries"
  homepage "https://developer.amd.com/amd-aocl/"
  version "3.1.0"
  url "file:#{HOMEBREW_LIBRARY}/Taps/pgarner/homebrew-tap/cache/aocl-linux-gcc-#{version}.tar.gz"
  sha256 "84d1848350f545140c3caf18bfdb28ab74c8c7eb4732e5fb17eb43ad28f850d7"
  license "AMD"

  def install
    # This actually installs to ./ then selectively installs the libs
    system "./install.sh", "-t", ".", "-i", "lp64"
    include.install Dir["#{version}/include_LP64/*"]
    lib.install Dir["#{version}/lib_LP64/*"]
  end

  test do
    system "false"
  end
end
