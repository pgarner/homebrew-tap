class Mkl < Formula
  desc "Intel Math Kernel Library"
  homepage "https://software.intel.com/en-us/mkl"
  version "2021.4.0"
  license "ISSL"
  
  # To shorten some paths
  lpath = "https://anaconda.org/intel/mkl/#{version}/download"
  ipath = "https://anaconda.org/intel/mkl-include/#{version}/download"

  on_linux do
    build = "intel_640"
    url "#{lpath}/linux-64/mkl-#{version}-#{build}.tar.bz2"
    sha256 "18818caac756ea1759f09a11d2faf97a475c4a18bda0cf40c6f056be46f31469"

    resource "mkl-include" do
      version Mkl.version
      url "#{ipath}/linux-64/mkl-include-#{version}-#{build}.tar.bz2"
      sha256 "1197bd0f3473e06f3ee056db50ff9e76072e4fc5b869698ffb70f864c6afb8aa"
    end
  end

  on_macos do
    build = "intel_637"
    url "#{lpath}/osx-64/mkl-#{version}-#{build}.tar.bz2"
    sha256 "0b0950c1f86de38fff4b7a3d1715a9681584467817bf0afdbc7f42322e86d17c"

    resource "mkl-include" do
      version Mkl.version
      url "#{ipath}/osx-64/mkl-include-#{version}-#{build}.tar.bz2"
      sha256 "c007d3c893d9aa9cc2aff9a542f90e722c2bdebae57b09293ba0032f3c91e632"
    end
  end

  depends_on "intel-openmp"

  def install
    resource('mkl-include').stage { include.install Dir["include/*"] }
    lib.install Dir["lib/*"]
    ln_s lib/".", lib/"intel64"
  end

  test do
    system "false"
  end
end
