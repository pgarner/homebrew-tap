class Cudnn < Formula
  desc "NVidia CuDNN Toolkit"
  homepage "https://developer.nvidia.com/cudnn"
  license "NVidia"
  version "8.0.0"
  url "https://anaconda.org/nvidia/cudnn/#{version}/download/linux-64/cudnn-#{version}-cuda10.2_0.tar.bz2"
  sha256 "424c4cd49f049010e08ffc28d0acec538bd6fb9eb8a89ffa4ae1dd3ebee72afa"

  depends_on :linux
  depends_on "cuda@10.2"

  def install
    lib.install Dir["lib/*"]
    include.install Dir["include/*"]
  end

  test do
    system "false"
  end
end

