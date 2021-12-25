class MklInclude < Formula
  desc "Intel Math Kernel Library"
  homepage "https://software.intel.com/en-us/mkl"
  version "2021.4.0"
  license "ISSL"

  intel = "https://anaconda.org/intel"

  on_linux do
    build = "intel_640"
    url "#{intel}/mkl-include/#{version}/download/linux-64/mkl-include-#{version}-#{build}.tar.bz2"
    sha256 "1197bd0f3473e06f3ee056db50ff9e76072e4fc5b869698ffb70f864c6afb8aa"
  end

  on_macos do
    build = "intel_637"
    url "#{intel}/mkl-include/#{version}/download/osx-64/mkl-include-#{version}-#{build}.tar.bz2"
    sha256 "c007d3c893d9aa9cc2aff9a542f90e722c2bdebae57b09293ba0032f3c91e632"
  end

  def install
    # There are .f90 and .fi files too, but hey...
    prefix.install "include"
  end

  test do
    system "false"
  end
end
