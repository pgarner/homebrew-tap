class Openspeech < Formula
  desc "Reference implementations of various ASR modeling papers"
  homepage "https://openspeech-team.github.io/openspeech/"
  version "0.3.0"
  url "https://github.com/openspeech-team/openspeech.git", tag: "v#{version}"
  head "https://github.com/openspeech-team/openspeech.git"
  license "MIT"

  depends_on "python3"
  depends_on "pytorch"

  def install
    ENV["VERBOSE"] = "1"
    xy = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH",
      "#{prefix}/lib/python#{xy}/site-packages"

    deps = [
      "pytorch-lightning"
    ]
    system "pip3", "-v", "install", "--prefix", "#{prefix}", *deps
    system "python3", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "false"
  end
end
