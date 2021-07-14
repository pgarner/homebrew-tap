class Cmudict < Formula
  desc "The Carnegie Mellon Pronouncing Dictionary"
  homepage "http://www.speech.cs.cmu.edu/cgi-bin/cmudict/"
  version "2021-05"
  url "https://github.com/cmusphinx/cmudict.git", revision: "4c6a365"
  license "CMU"

  def install
    pkgshare.install Dir["*"]
  end

  test do
    system "false"
  end
end
