class Vscode < Formula
  desc "Visual Studio Code"
  homepage "https://code.visualstudio.com/"
  version "1.71.0"
  url "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
  sha256 "28471a17013a4d272b70542f1bc49602b2cbeb582c6b4c46cc2d8f4b6a0619df"
  license "MIT"

  depends_on :linux

  def install
    Dir.glob("code_#{version}-*.deb") do |f|
      # In fact there should be only one file
      system "ar", "x", f, "data.tar.xz"
    end   
    system "tar", "Jxf", "data.tar.xz"
    cd "usr" do
      prefix.install "share"
      bin.install_symlink share/"code/bin/code"
    end
  end

  test do
    system "false"
  end
end
