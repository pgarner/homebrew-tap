class Hts < Formula
  desc "HMM/DNN-based Speech Synthesis System"
  homepage "http://hts.sp.nitech.ac.jp"
  version "2.3"
  @@htkversion = "3.4.1"
  @@string = "HTS-#{version}_for_HTK-#{@@htkversion}"
  url "http://hts.sp.nitech.ac.jp/archives/#{version}/#{@@string}.tar.bz2"
  sha256 "9fe2480f834a1b4c124abaef6fee423530a8a6de79015413f3ca1d1fdc7644de"
  license "HTK"

  cache = "file:#{HOMEBREW_LIBRARY}/Taps/pgarner/homebrew-tap/cache"

  resource "htk" do
    url "#{cache}/HTK-#{@@htkversion}.tar.gz"
    sha256 "42297b036ce3a47adeab26aaa42f51ac4b370ead7f53bab75fd27a52d38ae5ac"
  end

  resource "hdecode" do
    url "#{cache}/HDecode-#{@@htkversion}.tar.gz"
    sha256 "9517b25a91200e3e84ebed0d615f73715196dbfaf32ef854c2e964442175bee5"
  end

  def install
    resource("htk").stage     { cp_r Dir["*"], buildpath }
    resource("hdecode").stage { cp_r Dir["*"], buildpath }
    system "patch", "-p1", "-i", "#{@@string}.patch"

    args = %W[
      --enable-hdecode
      --disable-hslab
      --prefix=#{prefix}
    ]

    ENV.deparallelize
    system "./configure", *args
    system "make", "all"
    system "make", "install"
  end

  test do
    system "false"
  end
end
