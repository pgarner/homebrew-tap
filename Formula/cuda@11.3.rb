class CudaAT113 < Formula
  desc "NVidia CUDA Toolkit"
  homepage "https://developer.nvidia.com/cuda-zone"
  license "NVidia"
  version "11.3.1"
  vdriver = "465.19.01"
  url "https://developer.download.nvidia.com/compute/cuda/#{version}/local_installers/cuda_#{version}_#{vdriver}_linux.run"
  sha256 "ad93ea98efced35855c58d3a0fc326377c60917cb3e8c017d3e6d88819bf2934"

  keg_only :versioned_formula
  depends_on :linux

  def install
    vdriver = "465.19.01"
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
