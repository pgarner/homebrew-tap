class MklInclude < Formula
  desc "Intel Math Kernel Library"
  homepage "https://software.intel.com/en-us/mkl"
  version "2021.1.1"
  license "ISSL"

  intel = "https://anaconda.org/intel"

  on_linux do
    build = "intel_52"
    url "#{intel}/mkl-include/#{version}/download/linux-64/mkl-include-#{version}-#{build}.tar.bz2"
    sha256 "bb579d7b3d5e4ed1ca6b5efb94bf10ae24af75922282ba7c65856f94d1e81d8e"
  end

  on_macos do
    build = "intel_50"
    url "#{intel}/mkl-include/#{version}/download/osx-64/mkl-include-#{version}-#{build}.tar.bz2"
    sha256 ""
  end

  def install
    # There are .f90 and .fi files too...
    include.install Dir["include/*.h"]
  end

  test do
    system "false"
  end
end
