class LjSpeech < Formula
  desc "The LJ Speech Dataset"
  homepage "https://keithito.com/LJ-Speech-Dataset/"
  version "1.1"
  url "https://data.keithito.com/data/speech/LJSpeech-#{version}.tar.bz2"
  sha256 "be1a30453f28eb8dd26af4101ae40cbf2c50413b1bb21936cbcdc6fae3de8aa5"
  license "Public Domain"

  def install
    # There are these three things in the distribution, so just copy them
    pkgshare.install "README"
    pkgshare.install "metadata.csv"
    pkgshare.install "wavs"
  end

  test do
    system "false"
  end
end
