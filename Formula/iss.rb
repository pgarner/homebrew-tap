class Iss < Formula
  desc "Idiap Speech Scripts"
  homepage "https://github.com/idiap/iss"
  version "2018-11"
  url "https://github.com/idiap/iss.git"
  license "BSD-3-Clause"

  keg_only "Should be pointed at with $ISSROOT"

  def install
    # bin.install yields bin/bin
    prefix.install "bin"
    prefix.install "lib"
  end

  test do
    system "false"
  end
end
