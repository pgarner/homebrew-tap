# See: https://github.com/archlinux/svntogit-community/blob/packages/cudnn/trunk/PKGBUILD
# or: https://github.com/pytorch/builder/blob/master/common/install_cuda.sh
class CudnnAT82 < Formula
  desc "NVidia CuDNN Toolkit"
  homepage "https://developer.nvidia.com/cudnn"
  license "NVidia"
  version "8.2.0"
  cudaver = "11.3"
  url "https://developer.download.nvidia.com/compute/redist/cudnn/v#{version}/cudnn-#{cudaver}-linux-x64-v#{version}.53.tgz"
  sha256 "7a195dc93a7cda2bdd4d9b73958d259c784be422cd941a9a625aab75309f19dc"

  keg_only :versioned_formula
  depends_on :linux
  depends_on "cuda@11.3"

  def install
    lib.install Dir["lib64/*"]
    include.install Dir["include/*"]
  end

  test do
    system "false"
  end
end
