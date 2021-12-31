class LocalLib < Formula
  desc "Create and use a local lib/ for perl modules with PERL5LIB"
  homepage "https://github.com/Perl-Toolchain-Gang/local-lib"
  version "2.000028"
  url "https://github.com/Perl-Toolchain-Gang/local-lib/archive/refs/tags/v#{version}.tar.gz"
  sha256 "642e45981e29342aa7e2394a10c8575a1837aff5d2fd15ab92fe57fa494f3d34"
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
