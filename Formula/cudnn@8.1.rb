# See: https://github.com/archlinux/svntogit-community/blob/packages/cudnn/trunk/PKGBUILD
# or: https://github.com/pytorch/builder/blob/master/common/install_cuda.sh
class CudnnAT81 < Formula
  desc "NVidia CuDNN Toolkit"
  homepage "https://developer.nvidia.com/cudnn"
  license "NVidia"
  version "8.1.0"
  cudaver = "11.2"
  url "https://developer.download.nvidia.com/compute/redist/cudnn/v#{version}/cudnn-#{cudaver}-linux-x64-v#{version}.77.tgz"
  sha256 "dbe82faf071d91ba9bcf00480146ad33f462482dfee56caf4479c1b8dabe3ecb"

  keg_only :versioned_formula
  depends_on :linux
  depends_on "cuda@11.2"

  def install
    lib.install Dir["lib64/*"]
    include.install Dir["include/*"]
  end

  test do
    system "false"
  end
end
