class Numpy < Formula
  desc "Package for scientific computing with Python, built against MKL"
  homepage "https://www.numpy.org/"
  version "1.21.4"
  url "https://github.com/numpy/numpy/archive/refs/tags/v#{version}.tar.gz"
  sha256 "59a157443cfdb9d2576a14833ca1c1c9ef96fc091955a9b6829464df39501d8c"
  license "BSD-3-Clause"
  head "https://github.com/numpy/numpy.git", branch: "main"

  depends_on "mkl"
  depends_on "sys-python"

  def install
    ENV["ATLAS"] = "None" # avoid linking against Accelerate.framework
    ENV["MKLROOT"] = HOMEBREW_PREFIX
    ENV["VERBOSE"] = "1"
    system "python3", "setup.py", "build",
           "--fcompiler=gfortran", "--parallel=#{ENV.make_jobs}"
    system "python3", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "python3", "-c", <<~EOS
      import numpy as np
      t = np.ones((3,3), int)
      assert t.sum() == 9
      assert np.dot(t, t).sum() == 27
    EOS
  end
end
