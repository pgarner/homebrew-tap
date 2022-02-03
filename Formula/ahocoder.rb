class Ahocoder < Formula
  desc "AHOLAB's Harmonic plus Noise codec"
  homepage "https://aholab.ehu.eus/ahocoder/"
  version "0.99"
  url "http://aholab.ehu.es/users/derro/ahocoder_v099_x86_64.tar.gz"
  sha256 "b7fe57b8463918a151ef8a3b180bc81cb7db4ad42fb27a985e85b8ac3d33cf4d"
  license "AHOLAB"

  def install
    bin.install "ahocoder16_64"
    bin.install "ahodecoder16_64"
  end

  test do
    system "false"
  end
end
