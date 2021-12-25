class Mkl < Formula
  desc "Intel Math Kernel Library"
  homepage "https://software.intel.com/en-us/mkl"
  version "2021.4.0"
  license "ISSL"

  depends_on "mkl-include"
  depends_on "intel-openmp"

  intel = "https://anaconda.org/intel"

  on_linux do
    build = "intel_640"
    url "#{intel}/mkl/#{version}/download/linux-64/mkl-#{version}-#{build}.tar.bz2"
    sha256 "18818caac756ea1759f09a11d2faf97a475c4a18bda0cf40c6f056be46f31469"
  end

  on_macos do
    build = "intel_637"
    url "#{intel}/mkl/#{version}/download/osx-64/mkl-#{version}-#{build}.tar.bz2"
    sha256 "0b0950c1f86de38fff4b7a3d1715a9681584467817bf0afdbc7f42322e86d17c"
  end

  def install
    lib.install Dir["lib/*"]
    ln_s lib/".", lib/"intel64"
  end

  test do
    system "false"
  end
end
