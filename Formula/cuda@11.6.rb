class CudaAT116 < Formula
  desc "NVidia CUDA Toolkit"
  homepage "https://developer.nvidia.com/cuda-zone"
  license "NVidia"
  version "11.6.0"
  vdriver = "510.39.01"
  url "https://developer.download.nvidia.com/compute/cuda/#{version}/local_installers/cuda_#{version}_#{vdriver}_linux.run"
  sha256 "1783da6d63970786040980b57fa3cb6420142159fc7d0e66f8f05c4905d98c83"

  keg_only :versioned_formula
  depends_on :linux

  def install
    vdriver = "510.39.01" # Why does it get lost?
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
