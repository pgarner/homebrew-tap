#
# This is a *horrible* hack
# Brew's shims don't allow include paths into /usr/include. This means you
# can't use some system files, in this case /usr/include/pythonX.Y/*
# So, fool it into thinking it's a local install.
#
class SysPython < Formula
  desc "Links to cause homebrew to use the system's python"
  homepage "https://github.com/pgarner/homebrew-tap"
  version "2021.03"
  url "https://github.com/pgarner/homebrew-tap.git", revision: "bff5a40"
  license "BSD-3-Clause"

  keg_only "it's a horrible hack"

  def install
    xy = Language::Python.major_minor_version("python3")
    include.install_symlink Dir["/usr/include/python#{xy}/*"]
  end

  test do
    system "false"
  end
end
