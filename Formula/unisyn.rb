class Unisyn < Formula
  desc "Master lexicon transcribed in keysymbols"
  homepage "https://www.cstr.ed.ac.uk/projects/unisyn/"
  url "file:#{HOMEBREW_LIBRARY}/Taps/pgarner/homebrew-tap/cache/unisyn13.tgz"
  version "1.3"
  sha256 "c0c53c200b12fb09d453da868b2a3580712cdf9d9c7e792b7380042316971e3d"
  license "UEdin"

  patch :DATA

  def install
    pkgshare.install Dir["*"]
  end

  test do
    system "false"
  end
end

__END__
diff -Naur unilex.old/post-lex-rules.pl unilex/post-lex-rules.pl
--- unilex.old/post-lex-rules.pl	2021-07-15 15:05:20.151432000 +0200
+++ unilex/post-lex-rules.pl	2021-07-14 11:01:13.635374000 +0200
@@ -1889,7 +1889,7 @@
     my ($tmpline) = @_;
     push (@debug, "            \'$`$&$'\' -> \'$_\', matched on \'$&\', line $tmpline\n");
 #check no extra spaces introduced or deleted by rules - these can mess up subsequent rules
-    if (($_ =~ / {,3}[^ ]/) || ($_ =~ /[^ ] {,3}/) || ($_ =~ /[^\s] [^\s]/)) {
+    if (($_ =~ / \{,3\}[^ ]/) || ($_ =~ /[^ ] \{,3\}/) || ($_ =~ /[^\s] [^\s]/)) {
 	push (@debug, "PROBABLE SPACING ERROR \'$&\', INTRODUCED AT LINE $tmpline\n");
     }
 }
