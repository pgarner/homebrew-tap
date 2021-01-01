#
# See the Arch PKGBUILD for reference:
#  https://github.com/archlinux/svntogit-community/blob/packages/intel-mkl/trunk/PKGBUILD
# although this one just relies on the packaged installer for the moment
#
class IntelMkl < Formula
  desc "Intel Math Kernel Library"
  homepage "https://software.intel.com/en-us/mkl"
  version "2020.4.304"
  url "http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/16917/l_mkl_#{version}.tgz"
  sha256 "2314d46536974dbd08f2a4e4f9e9a155dc7e79e2798c74e7ddfaad00a5917ea5"
  license "ISSL"

  depends_on :linux
  depends_on "cpio" => :build

  def install
    cfgfile = buildpath/"brew.cfg"
    cfgfile.write <<~EOS
      ACCEPT_EULA=accept
      CONTINUE_WITH_OPTIONAL_ERROR=yes
      PSET_INSTALL_DIR=#{prefix}
      CONTINUE_WITH_INSTALLDIR_OVERWRITE=yes
      COMPONENTS=DEFAULTS
      PSET_MODE=install
      SIGNING_ENABLED=no
      ARCH_SELECTED=INTEL64
    EOS
    system "sh", "install.sh", "-s", cfgfile
  end

  test do
    system "false"
  end
end
