class CudaCompatAT114 < Formula
  desc "NVidia CUDA compatibility library"
  homepage "https://www.nvidia.com/Download/index.aspx"
  license "NVidia"
  version "11.4.0"
  vdriver = "470.82.01"
  url "https://us.download.nvidia.com/tesla/#{vdriver}/NVIDIA-Linux-x86_64-#{vdriver}.run"
  sha256 "ad78fc2b29b8f498015277e30ae42530b61fecc298706bc0e9c193ee5e9c0660"

  keg_only :versioned_formula
  depends_on :linux
  depends_on "cuda"

  def install
    vdriver = "470.82.01" # Why does it get lost?
    vdir = "NVIDIA-Linux-x86_64-#{vdriver}"
    cudso = "libcuda.so"
    ptxso = "libnvidia-ptxjitcompiler.so"
    system "sh", "#{vdir}.run", "-x"
    cd buildpath/vdir do
      lib.install "#{ptxso}.#{vdriver}"
      lib.install "#{cudso}.#{vdriver}"
      ln_s lib/"#{ptxso}.#{vdriver}", lib/"#{ptxso}.1"
      ln_s lib/"#{cudso}.#{vdriver}", lib/"#{cudso}.1"
      ln_s lib/"#{cudso}.1", lib/"#{cudso}"
    end
  end

  test do
    system "false"
  end
end
