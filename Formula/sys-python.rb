class SysPython < Formula
  include Language::Python::Virtualenv

  desc "Cause homebrew to use the system's python3"
  homepage "https://github.com/pgarner/homebrew-tap"
  version "2021.11"
  url "https://github.com/pgarner/homebrew-tap.git", tag: "dummy"
  license "BSD-3-Clause"

  def install
    # This is a perfectly reasonable hack
    virtualenv_create(prefix, "python3")
    Dir.glob("#{prefix}/bin/pip*").each do |pip|
      inreplace pip, /Cellar.*#{version}\//, ""
    end

    on_linux do
      # This is a *horrible* hack
      # Brew's shims don't allow include paths into /usr/include. This means
      # you can't use some system files, in this case /usr/include/pythonX.Y/*
      # So, fool it into thinking it's a local install.
      xy = Language::Python.major_minor_version("python3")
      include.install_symlink Dir["/usr/include/python#{xy}/*"]
    end

    # This is an unpleasant hack
    HOMEBREW_PREFIX.install "#{prefix}/pyvenv.cfg"
  end

  test do
    system "false"
  end
end
