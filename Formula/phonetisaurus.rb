class Phonetisaurus < Formula
  desc "Phonetisaurus G2P"
  homepage "https://github.com/AdolfVonKleist/Phonetisaurus"
  version "0.9.1"
  url "https://github.com/AdolfVonKleist/Phonetisaurus.git", tag: version
  license "BSD-3-Clause"

  depends_on "mitlm"
  depends_on "openfst@1.6.7"  # Same one as Kaldi

  def install
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make", "install"
  end

  test do
    system "false"
  end
end
