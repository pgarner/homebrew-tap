# See: https://github.com/archlinux/svntogit-community/blob/packages/cudnn/trunk/PKGBUILD
# or: https://github.com/pytorch/builder/blob/master/common/install_cuda.sh
class CudnnAT111 < Formula
  desc "NVidia CuDNN Toolkit"
  homepage "https://developer.nvidia.com/cudnn"
  license "NVidia"
  version "8.0.5"
  cudaver = "11.1"
  url "https://developer.download.nvidia.com/compute/redist/cudnn/v#{version}/cudnn-#{cudaver}-linux-x64-v#{version}.39.tgz"
  sha256 "1d046bfa79399dabcc6f6cb1507918754439442ea0ca9e0fbecdd446f9b00cce"

  keg_only :versioned_formula
  depends_on :linux
  depends_on "cuda@11.1"

  def install
    lib.install Dir["lib64/*"]
    include.install Dir["include/*"]
  end

  test do
    system "false"
  end
end
