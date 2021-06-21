class Vscode < Formula
  desc "Visual Studio Code"
  homepage "https://code.visualstudio.com/"
  version "1.56.2"
  url "https://update.code.visualstudio.com/latest/linux-deb-x64/stable"
  sha256 "a5a50ec014b27656c198e560796f3b41180f3bdb0c19f0005193f79ed47fc8b8"
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
