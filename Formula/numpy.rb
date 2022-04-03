class Numpy < Formula
  desc "Package for scientific computing with Python"
  homepage "https://www.numpy.org/"
  url "https://files.pythonhosted.org/packages/64/4a/b008d1f8a7b9f5206ecf70a53f84e654707e7616a771d84c05151a4713e9/numpy-1.22.3.zip"
  sha256 "dbc7601a3b7472d559dc7b933b18b4b66f9aa7452c120e87dfb33d02008c8a18"
  license "BSD-3-Clause"
  head "https://github.com/numpy/numpy.git", branch: "main"

  depends_on "cython" => :build
  depends_on "mkl"
  depends_on "python3"

  fails_with gcc: "5"

  def install
    ENV["ATLAS"] = "None" # avoid linking against Accelerate.framework
    ENV["MKLROOT"] = Formula["mkl"].opt_prefix
    ENV["VERBOSE"] = "1"

    xy = Language::Python.major_minor_version Formula["python3"].opt_bin/"python3"
    ENV.prepend_create_path "PYTHONPATH", Formula["cython"].opt_libexec/"lib/python#{xy}/site-packages"

    on_linux do
      system Formula["python3"].opt_bin/"python3", "setup.py", "build",
             "--fcompiler=#{Formula["gcc"].opt_bin}/gfortran", "--parallel=#{ENV.make_jobs}"
    end
    on_macos do
      system Formula["python3"].opt_bin/"python3", "setup.py", "build",
             "--parallel=#{ENV.make_jobs}"
    end
    system Formula["python3"].opt_bin/"python3", *Language::Python.setup_install_args(prefix)
  end

  test do
    system Formula["python3"].opt_bin/"python3", "-c", <<~EOS
      import numpy as np
      t = np.ones((3,3), int)
      assert t.sum() == 9
      assert np.dot(t, t).sum() == 27
    EOS
  end
end
