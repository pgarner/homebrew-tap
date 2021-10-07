class IntelOpenmp < Formula
  desc "Intel OpenMP"
  homepage "https://software.intel.com/en-us/mkl"
  version "2021.3.0"
  license "ISSL"

  intel = "https://anaconda.org/intel"

  on_linux do
    build = "intel_3350"
    url "#{intel}/intel-openmp/#{version}/download/linux-64/intel-openmp-#{version}-#{build}.tar.bz2"
    sha256 "db33da863e2031af388ddff6f8194fa5954a85993fa7e39a98fc91e92632cf67"
  end

  on_macos do
    build = "intel_3375"
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
