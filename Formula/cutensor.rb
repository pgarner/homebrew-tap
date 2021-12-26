class Cutensor < Formula
  desc "Tensor Linear Algebra on NVIDIA GPUs"
  homepage "https://developer.nvidia.com/cutensor"
  license "NVidia"
  version "1.4.0.6"
  url "https://developer.download.nvidia.com/compute/cutensor/redist/libcutensor/linux-x86_64/libcutensor-linux-x86_64-#{version}-archive.tar.xz"
  sha256 "467ba189195fcc4b868334fc16a0ae1e51574139605975cc8004cedebf595964"

  depends_on :linux
  depends_on "cuda11"

  def install
    include.install Dir["include/*"]
    lib.install Dir["lib/11/*"]
  end

  test do
    system "false"
  end
end
