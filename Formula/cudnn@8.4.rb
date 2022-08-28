# See: https://github.com/archlinux/svntogit-community/blob/packages/cudnn/trunk/PKGBUILD
# or: https://github.com/pytorch/builder/blob/master/common/install_cuda.sh
class CudnnAT84 < Formula
  desc "NVidia CuDNN Toolkit"
  homepage "https://developer.nvidia.com/cudnn"
  license "NVidia"
  version "8.4.1"
  cudaver = "11.6"
  url "https://developer.download.nvidia.com/compute/redist/cudnn/v#{version}/local_installers/#{cudaver}/cudnn-linux-x86_64-#{version}.50_cuda#{cudaver}-archive.tar.xz"
  sha256 "ec96d2376d81fca42bdd3d4c3d705a99b29a065bab57f920561c763e29c67d01"

  keg_only :versioned_formula
  depends_on :linux
  depends_on "cuda@11.6"

  def install
    lib.install Dir["lib/*"]
    include.install Dir["include/*"]
  end

  test do
    system "false"
  end
end
