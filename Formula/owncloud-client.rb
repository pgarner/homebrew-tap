class OwncloudClient < Formula
  desc "Desktop Syncing Client for ownCloud"
  homepage "http://owncloud.org/"
  version "2.11.1"
  url "https://github.com/owncloud/client/archive/refs/tags/v#{version}.tar.gz"
  sha256 "72e13d90e4d1c71bdf863a2387f36bcccbc5b410aac2d93144fe3567056ba599"
  head "https://github.com/owncloud/client.git"
  license "GPL-2.0"

  depends_on "cmake" => :build

  # Right now it expects to be run from $HOMEBREW_PREFIX in order to find
  # etc/ownCloud/sync-exclude.lst
  # It should be possible to fix some flag to force an absolute path.
  def install
    system "cmake", ".", *std_cmake_args
    system "cmake", "--build", "."
    system "cmake", "--install", "."
  end

  test do
    system "false"
  end
end
