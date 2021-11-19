class SysOpenmpi < Formula
  desc "Cause homebrew to use the (Debian) system's openmpi"
  homepage "https://github.com/pgarner/homebrew-tap"
  version "2021.11"
  url "https://github.com/pgarner/homebrew-tap.git", tag: "dummy"
  license "BSD-3-Clause"

  def install
    # This is a *horrible* hack
    # Brew's shims don't allow include paths into /usr/include. This means
    # you can't use some system files.
    # So, fool it into thinking it's a local install.
    include.install_symlink Dir["/usr/lib/x86_64-linux-gnu/openmpi/include/*"]
  end

  test do
    system "false"
  end
end
