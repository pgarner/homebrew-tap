class SpeechBrain < Formula
  desc "A PyTorch Powered Speech Toolkit"
  homepage "https://speechbrain.github.io/"
  version "2021.03"
  url "https://github.com/speechbrain/speechbrain.git", revision: "98f02d9"
  license "Apache-2.0"

  depends_on "pytorch"

  on_macos do
    uses_from_macos "python@3"
  end

  def install
    xy = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH",
      "#{HOMEBREW_PREFIX}/lib/python#{xy}/site-packages"
    system "pip3", "-v", "install", "--prefix", "#{prefix}", "."
  end

  test do
    system "false"
  end
end
