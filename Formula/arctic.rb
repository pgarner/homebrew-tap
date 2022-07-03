class Arctic < Formula
  desc "CMU_ARCTIC speech synthesis databases"
  homepage "http://www.festvox.org/cmu_arctic/"
  url "http://www.festvox.org/cmu_arctic/cmuarctic.data"
  version "2022.07"
  sha256 "60e3d9a4dc33732c9100baadd747312bdc1a200fc891766507397289753a25c7"
  license "??"
  @@orig = "http://www.festvox.org/cmu_arctic/cmu_arctic/orig"
  @@packed = "http://www.festvox.org/cmu_arctic/packed"

  resource "orig.bdl" do
    url "#{@@orig}/cmu_us_bdl_arctic-WAVEGG.tar.bz2"
    sha256 "bdae8de8689752caa5ef8ad2cb9b94fb0d9c2a3ee6dee6907d51dbba51c3b653"
  end

  resource "orig.jmk" do
    url "#{@@orig}/cmu_us_jmk_arctic-WAVEGG.tar.bz2"
    sha256 "8089374059b2706e1c7add9fee758d4052db7167edfbaea81358a7057e1be5b1"
  end

  resource "orig.slt" do
    url "#{@@orig}/cmu_us_slt_arctic-WAVEGG.tar.bz2"
    sha256 "91e9c76429f2b5d8aa65f490af22af6b180be232811e5a133132d4e98cf8ed48"
  end

  resource "aew" do
    url "#{@@packed}/cmu_us_aew_arctic.tar.bz2"
    sha256 "645cb33c0f0b2ce41384fdd8d3db2c3f5fc15c1e688baeb74d2e08cab18ab406"
  end

  resource "ahw" do
    url "#{@@packed}/cmu_us_ahw_arctic.tar.bz2"
    sha256 "024664adeb892809d646a3efd043625b46b5bfa3e6189b3500b2d0d59dfab06c"
  end

  resource "aup" do
    url "#{@@packed}/cmu_us_aup_arctic.tar.bz2"
    sha256 "2c55bc3050caa996758869126ad10cf42e1441212111db034b3a45189c18b6fc"
  end

  resource "awb" do
    url "#{@@packed}/cmu_us_awb_arctic.tar.bz2"
    sha256 "d74a950c9739a65f7bfc4dfa6187f2730fa03de5b8eb3f2da97a51b74df64d3c"
  end

  resource "axb" do
    url "#{@@packed}/cmu_us_axb_arctic.tar.bz2"
    sha256 "dd65c3d2907d1ee52f86e44f578319159e60f4bf722a9142be01161d84e330ff"
  end

  resource "bdl" do
    url "#{@@packed}/cmu_us_bdl_arctic.tar.bz2"
    sha256 "26b91aaf48b2799b2956792b4632c2f926cd0542f402b5452d5adecb60942904"
  end

  resource "clb" do
    url "#{@@packed}/cmu_us_clb_arctic.tar.bz2"
    sha256 "3f16dc3f3b97955ea22623efb33b444341013fc660677b2e170efdcc959fa7c6"
  end

  resource "eey" do
    url "#{@@packed}/cmu_us_eey_arctic.tar.bz2"
    sha256 "8a0ee4e5acbd4b2f61a4fb947c1730ab3adcc9dc50b195981d99391d29928e8a"
  end

  resource "fem" do
    url "#{@@packed}/cmu_us_fem_arctic.tar.bz2"
    sha256 "3fcff629412b57233589cdb058f730594a62c4f3a75c20de14afe06621ef45e2"
  end

  resource "gka" do
    url "#{@@packed}/cmu_us_gka_arctic.tar.bz2"
    sha256 "dc82e7967cbd5eddbed33074b0699128dbd4482b41711916d58103707e38c67f"
  end

  resource "jmk" do
    url "#{@@packed}/cmu_us_jmk_arctic.tar.bz2"
    sha256 "3a37c0e1dfc91e734fdbc88b562d9e2ebca621772402cdc693bbc9b09b211d73"
  end

  resource "ksp" do
    url "#{@@packed}/cmu_us_ksp_arctic.tar.bz2"
    sha256 "8029cafce8296f9bed3022c44ef1e7953332b6bf6943c14b929f468122532717"
  end

  resource "ljm" do
    url "#{@@packed}/cmu_us_ljm_arctic.tar.bz2"
    sha256 "b23993765cbf2b9e7bbc3c85b6c56eaf292ac81ee4bb887b638a24d104f921a0"
  end

  resource "lnh" do
    url "#{@@packed}/cmu_us_lnh_arctic.tar.bz2"
    sha256 "4faf34d71aa7112813252fb20c5433e2fdd9a9de55a00701ffcbf05f24a5991a"
  end

  resource "rms" do
    url "#{@@packed}/cmu_us_rms_arctic.tar.bz2"
    sha256 "c6dc11235629c58441c071a7ba8a2d067903dfefbaabc4056d87da35b72ecda4"
  end

  resource "rxr" do
    url "#{@@packed}/cmu_us_rxr_arctic.tar.bz2"
    sha256 "1fa4271c393e5998d200e56c102ff46fcfea169aaa2148ad9e9469616fbfdd9b"
  end

  resource "slp" do
    url "#{@@packed}/cmu_us_slp_arctic.tar.bz2"
    sha256 "54345ed55e45c23d419e9a823eef427f1cc93c83a710735ec667d068c916abf1"
  end

  resource "slt" do
    url "#{@@packed}/cmu_us_slt_arctic.tar.bz2"
    sha256 "7c173297916acf3cc7fcab2713be4c60b27312316765a90934651d367226b4ea"
  end

  def install
    pack = [
      "aew", "ahw", "aup", "awb", "axb", "bdl", "clb", "eey", "fem",
      "gka", "jmk", "ksp", "ljm", "lnh", "rms", "rxr", "slp", "slt"
    ]
    orig = ["bdl", "jmk", "slt"]
    pack.each do |spk|
      resource(spk).stage pkgshare/spk
    end
    orig.each do |spk|
      resource("orig.#{spk}").stage pkgshare/spk
    end    
    pkgshare.install "cmuarctic.data"
  end

  test do
    system "false"
  end
end
