class Mkl < Formula
  desc "Intel Math Kernel Library"
  homepage "https://software.intel.com/en-us/mkl"
  version "2021.3.0"
  license "ISSL"

  depends_on "mkl-include"
  depends_on "intel-openmp"

  intel = "https://anaconda.org/intel"

  on_linux do
    build = "intel_520"
    url "#{intel}/mkl/#{version}/download/linux-64/mkl-#{version}-#{build}.tar.bz2"
    sha256 "d0711fa1901c1b051f8a80922dbe20f1240c089d8eafcd24d40dc0f1977abe64"
  end

  on_macos do
    build = "intel_517"
    url "#{intel}/mkl/#{version}/download/osx-64/mkl-#{version}-#{build}.tar.bz2"
    sha256 "af4cb9716a780a5d222817dda9a7efeaef90177423593f42447fd9bf63ca9f13"
  end

  def install
    lib.install Dir["lib/*"]
    ln_s lib/".", lib/"intel64"
  end

  test do
    system "false"
  end
end
