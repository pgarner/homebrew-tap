class Cuda < Formula
  desc "NVidia CUDA Toolkit"
  homepage "https://developer.nvidia.com/cuda-zone"
  license "NVidia"
  version "11.2.0"
  vdriver = "460.27.04"
  url "https://developer.download.nvidia.com/compute/cuda/#{version}/local_installers/cuda_#{version}_#{vdriver}_linux.run"
  sha256 "9c50283241ac325d3085289ed9b9c170531369de41165ce271352d4a898cbdce"

  keg_only "bin/../nvvm expected to exist"
  depends_on :linux

  def install
    vdriver = "460.27.04" # Why does it get lost?
    system "sh", "cuda_#{version}_#{vdriver}_linux.run",
           "--installpath=#{prefix}",
           "--silent", "--override", "--toolkit",
           "--no-man-page", "--no-drm", "--no-opengl-libs"

    # These two links cause trouble for brew; why?  Anyway, this works:
    rm "#{prefix}/include"
    rm "#{prefix}/lib64"
    include.install_symlink Dir["#{prefix}/targets/x86_64-linux/include/*"]
    lib.install_symlink Dir["#{prefix}/targets/x86_64-linux/lib/*"]
  end

  test do
    system "false"
  end
end
