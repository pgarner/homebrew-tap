class LocalLib < Formula
  desc "Create and use a local lib/ for perl modules with PERL5LIB"
  homepage "https://github.com/Perl-Toolchain-Gang/local-lib"
  version "2.000_025"
  url "https://github.com/Perl-Toolchain-Gang/local-lib/archive/refs/tags/v#{version}.tar.gz"
  sha256 "ec1c854178157f8fcd87d6bdb9f9f623650270e3ed7d6604443225a82aca818d"
  head "https://github.com/Perl-Toolchain-Gang/local-lib.git"
  license "Perl5"

  on_macos do
    uses_from_macos "perl"
  end

  def install
    system "perl", "Makefile.PL", "--bootstrap=#{prefix}"
    system "make", "install"
  end

  test do
    system "false"
  end
end
