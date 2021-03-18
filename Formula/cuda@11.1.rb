class CudaAT111 < Formula
  desc "NVidia CUDA Toolkit"
  homepage "https://developer.nvidia.com/cuda-zone"
  license "NVidia"
  version "11.1.1"
  vdriver = "455.32.00"
  url "https://developer.download.nvidia.com/compute/cuda/#{version}/local_installers/cuda_#{version}_#{vdriver}_linux.run"
  sha256 "3eae6727086024925ebbcef3e9a45ad379d8490768fd00f9c2d8b6fd9cd8dd8f"

  keg_only :versioned_formula
  depends_on :linux

  def install
    vdriver = "455.32.00"
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
