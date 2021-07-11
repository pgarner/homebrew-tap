class Festvox < Formula
  desc "CMU Festvox Project"
  homepage "http://festvox.org"
#  version "2.7" # Festival 2.4
  version "2.8" # Festival 2.5.0
  url "https://github.com/pgarner/homebrew-tap/archive/refs/tags/dummy.tar.gz"
  sha256 "b1369ef1a145bd7a84e477e9290fdacaa42ea348a55bab6150b766e4342dc50d"
  license "Festvox"

  resource "speech_tools" do
    url "http://festvox.org/packed/festival/2.5/speech_tools-2.5.0-release.tar.gz"
    sha256 "e4fd97ed78f14464358d09f36dfe91bc1721b7c0fa6503e04364fb5847805dcc"
  end

  resource "festival" do
    url "http://festvox.org/packed/festival/2.5/festival-2.5.0-release.tar.gz"
    sha256 "4c9007426b125290599d931df410e2def51e68a8aeebd89b4a61c7c96c09a4b4"
  end

  resource "festlex_CMU" do
    url "http://festvox.org/packed/festival/2.5/festlex_CMU.tar.gz"
    sha256 "c19430919bca45d5368cd4c82af6153fbcc96a487ebd30b78b5f3c08718b7c07"
  end

  resource "festlex_OALD" do
    url "http://festvox.org/packed/festival/2.5/festlex_OALD.tar.gz"
    sha256 "e33a345390d4c76f8b987b06a5332bcdd0b168cf67c95ddc3270f9163cbe61f8"
  end

  resource "festlex_POSLEX" do
    url "http://festvox.org/packed/festival/2.5/festlex_POSLEX.tar.gz"
    sha256 "e7c6e3642dbd5b0d64942bc015a986fdd6244a79e51ec2e8309e63d569e49ea3"
  end

  resource "festvox_kallpc16k" do
    url "http://festvox.org/packed/festival/2.5/voices/festvox_kallpc16k.tar.gz"
    sha256 "809c4ab5ed9e4df4a658b58d5c56fe35055723f00d81a238168f5a1ebdaed08c"
  end

  resource "festvox_rablpc16k" do
    url "http://festvox.org/packed/festival/2.5/voices/festvox_rablpc16k.tar.gz"
    sha256 "ecd14b77c528e94dfb076e44050102fe8fba57e5fe813acf78a66629317f52a5"
  end

  def install

    mkdir prefix/"speech_tools" do
      resource("speech_tools").stage { cp_r Dir["*"], prefix/"speech_tools" }
      ENV.deparallelize
      system "./configure", "--prefix=#{prefix/"speech_tools"}"
      system "make"
      bin.install_symlink Dir[prefix/"speech_tools/bin/*"]
    end

    mkdir prefix/"festival" do
      resource("festival").stage { cp_r Dir["*"], prefix/"festival" }
      ENV.deparallelize
      system "./configure", "--prefix=#{prefix/"festival"}"
      system "make"
      bin.install_symlink Dir[prefix/"festival/bin/*"]
    end

    for lex in ["festlex_CMU", "festlex_OALD", "festlex_POSLEX"] do
      resource(lex).stage { cp_r "lib", prefix/"festival" }
    end

    for voice in ["festvox_kallpc16k", "festvox_rablpc16k"] do
      resource(voice).stage { cp_r "lib", prefix/"festival" }
    end

  end

  test do
    system "false"
  end
end
