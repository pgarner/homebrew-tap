class Asrt < Formula
  desc "Automatic Speech Recognition Tools"
  homepage "https://github.com/idiap/asrt"
  version "2020-04"
  url "https://github.com/idiap/asrt.git"
  license "BSD-3-Clause"

  depends_on "python3"

  def install
    ENV["VERBOSE"] = "1"
    deps = [
      "nltk",
      "roman",
      "num2words",
      "unicodecsv"
    ]
    system "pip3", "-v", "install", "--prefix", "#{prefix}", *deps
    system "python3", *Language::Python.setup_install_args(prefix)
  end

  test do
    system "false"
  end
end
