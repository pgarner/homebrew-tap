class Mkl < Formula
  desc "Intel Math Kernel Library"
  homepage "https://software.intel.com/en-us/mkl"
  version "2021.1.1"
  license "ISSL"

  depends_on "mkl-include"
  depends_on "intel-openmp"

  intel = "https://anaconda.org/intel"

  on_linux do
    build = "intel_52"
    url "#{intel}/mkl/#{version}/download/linux-64/mkl-#{version}-#{build}.tar.bz2"
    sha256 "bfb0fd056576cad99ae1d9c69ada2745420da9f9cf052551d5b91f797538bda2"
  end

  on_macos do
    build = "intel_50"
    url "#{intel}/mkl/#{version}/download/osx-64/mkl-#{version}-#{build}.tar.bz2"
    sha256 "819fb8875909d4d024e2a936c54b561aebd1e3aebe58fc605c70aa1ad9a66b70"
  end

  def install
    lib.install Dir["lib/*"]
    ln_s lib/".", lib/"intel64"
  end

  test do
    system "false"
  end
end
