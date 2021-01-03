class CudaAT102 < Formula
  desc "NVidia CUDA Toolkit"
  homepage "https://developer.nvidia.com/cuda-zone"
  license "NVidia"
  version "10.2"
  vdriver = "440.33.01"
  vbuild = "89"
  url "https://developer.download.nvidia.com/compute/cuda/#{version}/Prod/local_installers/cuda_#{version}.#{vbuild}_#{vdriver}_linux.run"
  sha256 "560d07fdcf4a46717f2242948cd4f92c5f9b6fc7eae10dd996614da913d5ca11"

  keg_only :versioned_formula
  depends_on :linux

  def install
    vdriver = "440.33.01" # Why does it get lost?
    vbuild = "89"
    system "sh", "cuda_#{version}.#{vbuild}_#{vdriver}_linux.run",
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
