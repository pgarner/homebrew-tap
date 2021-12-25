class IntelOpenmp < Formula
  desc "Intel OpenMP"
  homepage "https://software.intel.com/en-us/mkl"
  version "2021.4.0"
  license "ISSL"

  intel = "https://anaconda.org/intel"

  on_linux do
    build = "intel_3561"
    url "#{intel}/intel-openmp/#{version}/download/linux-64/intel-openmp-#{version}-#{build}.tar.bz2"
    sha256 "cc5ca9b203deaa8b7b36ff5cf9a9a98d6cf5f0a33f67967c8c38ec65639b7cb7"
  end

  on_macos do
    build = "intel_3538"
    url "#{intel}/intel-openmp/#{version}/download/osx-64/intel-openmp-#{version}-#{build}.tar.bz2"
    sha256 "3d3dd340e204d7154829137344fa8c581c3e8cd44be7fbb6484215e76d39b190"
  end

  def install
    lib.install Dir["lib/*"]
  end

  test do
    system "false"
  end
end
