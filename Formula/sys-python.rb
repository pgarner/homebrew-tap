#
# The stuff to move site_packages is more or less copied from
# homebrew-core/python@3.9
#
class SysPython < Formula
  include Language::Python::Virtualenv

  desc "Cause homebrew to use the system's python3"
  homepage "https://github.com/pgarner/homebrew-tap"
  version "2021.11"
  url "https://github.com/pgarner/homebrew-tap.git", tag: "dummy"
  license "BSD-3-Clause"

  def xy
    Language::Python.major_minor_version("python3")
  end

  def site_packages_cellar
    prefix/"lib/python#{xy}/site-packages"
  end

  def site_packages
    HOMEBREW_PREFIX/"lib/python#{xy}/site-packages"
  end

  def install
    # This is a perfectly reasonable hack
    # Just install a virtual environment against the system's python3
    virtualenv_create(prefix, "python3")
    site_packages_cellar.rmtree

    on_linux do
      # This is a *horrible* hack
      # Brew's shims don't allow include paths into /usr/include. This means
      # you can't use some system files, in this case /usr/include/pythonX.Y/*
      # So, fool it into thinking it's a local install.
      include.install_symlink Dir["/usr/include/python#{xy}/*"]
    end
  end

  def post_install
    # Cause the cellar's site_packages to link back to a common one
    site_packages.mkpath
    site_packages_cellar.unlink if site_packages_cellar.exist?
    site_packages_cellar.parent.install_symlink site_packages
    system bin/"python3", "-m", "ensurepip"
  end

  test do
    system "false"
  end
end
