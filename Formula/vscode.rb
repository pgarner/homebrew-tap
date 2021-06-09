class Vscode < Formula
  desc "Visual Studio Code"
  homepage "https://code.visualstudio.com/"
  version "1.56.2"
  url "https://update.code.visualstudio.com/latest/linux-deb-x64/stable"
  sha256 "4fe506b12aa0043ec955d11388f34f5dee12e1cade7bfce654193cc7275cb0fd"
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
