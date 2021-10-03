class MklInclude < Formula
  desc "Intel Math Kernel Library"
  homepage "https://software.intel.com/en-us/mkl"
  version "2021.3.0"
  license "ISSL"

  intel = "https://anaconda.org/intel"

  on_linux do
    build = "intel_520"
    url "#{intel}/mkl-include/#{version}/download/linux-64/mkl-include-#{version}-#{build}.tar.bz2"
    sha256 "b0df7fb4c2071fdec87b567913715a2e47dca05e8c3ac4e5bcf072d7804085af"
  end

  on_macos do
    build = "intel_50"
    url "#{intel}/mkl-include/#{version}/download/osx-64/mkl-include-#{version}-#{build}.tar.bz2"
    sha256 "51e7dc29437249973072b878fc67a8223f99da2af211f09a1f9ef0d9ea599817"
  end

  def install
    # There are .f90 and .fi files too, but hey...
    prefix.install "include"
  end

  test do
    system "false"
  end
end
