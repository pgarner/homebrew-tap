class Vscode < Formula
  desc "Visual Studio Code"
  homepage "https://code.visualstudio.com/"
  version "1.56.2"
  url "https://update.code.visualstudio.com/latest/linux-deb-x64/stable"
  sha256 "7cc34e7405875f4f6e3237aed48fbd5a2f0c1907175040a4a409ebe757a07e8d"
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
