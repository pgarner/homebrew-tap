class CudaCompat < Formula
  desc "NVidia CUDA compatibility library"
  homepage "https://www.nvidia.com/Download/index.aspx"
  license "NVidia"
  version "11.2.0"
  vdriver = "460.32.03"
  url "https://us.download.nvidia.com/tesla/#{vdriver}/NVIDIA-Linux-x86_64-#{vdriver}.run"
  sha256 "4f2122fc23655439f214717c4c35ab9b4f5ab8537cddfdf059a5682f1b726061"

  keg_only "It's only required in compatibility circumstances"
  depends_on :linux

  def install
    vdriver = "460.32.03" # Why does it get lost?
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
