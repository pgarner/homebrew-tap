#
# This is quite big: 3G download, 5G unpack and 5G installation
# Consider using
#   HOMEBREW_TEMP=/somewhere/big brew install cuda
#
class Cuda < Formula
  desc "NVidia CUDA Toolkit"
  homepage "https://developer.nvidia.com/cuda-zone"
  license "NVidia"
  version "11.2.0"
  vdriver = "460.27.04"
  url "https://developer.download.nvidia.com/compute/cuda/#{version}/local_installers/cuda_#{version}_#{vdriver}_linux.run"
  sha256 "9c50283241ac325d3085289ed9b9c170531369de41165ce271352d4a898cbdce"

  depends_on :linux

  def install
    vdriver = "460.27.04" # Why does it get lost?
    system "sh", "cuda_#{version}_#{vdriver}_linux.run",
           "--installpath=#{prefix}",
           "--silent", "--override", "--toolkit",
           "--no-man-page", "--no-drm", "--no-opengl-libs"
    #include.install Dir["include/*"]
    #lib.install Dir["lib64/*"]
  end

  test do
    system "false"
  end
end
