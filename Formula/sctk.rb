class Sctk < Formula
  desc "The NIST Scoring Toolkit"
  homepage "https://www.nist.gov/itl/iad/mig/tools"
  license "NIST"
  version "2.4.11"
  url "https://github.com/usnistgov/SCTK.git", :revision => "20159b5"
  sha256 "40fd0efb9bc1bf8bb7a899bc7425fc9c3a9cd17cf9b71c0f71cfb210b6c10733"

  patch :DATA

  def install
    system "make", "PREFIX=#{prefix}", "config"
    system "make", "all"
    bin.mkpath
    system "make", "install"
  end

  test do
    system "false"
  end
end

__END__
diff --git a/src/sclite/config.in b/src/sclite/config.in
index ebc0447..d48afb3 100644
--- a/src/sclite/config.in
+++ b/src/sclite/config.in
@@ -46,7 +46,7 @@ echo "test suite will fail."
 echo ""
 echo "    Do you want to enable alignments via GNU's 'diff'.  yes or no"
 echo ""
-ans=""
+ans="no"
 while test "$ans" = "" ; do 
 	read ans
 	ans=`echo $ans | tr 'A-Z' 'a-z'`
@@ -100,7 +100,7 @@ echo "the SLM toolkit is optionally, depending on your needs."
 echo ""
 echo "    Do you want to compile in the CMU-Cambridge SLM toolkit?.  yes or no"
 echo ""
-ans=""
+ans="no"
 SLM_DEFS=""
 while test "$ans" = "" ; do 
 	read ans
diff --git a/src/sclite/makefile.in b/src/sclite/makefile.in
index a8c5ac4..9d4b78b 100644
--- a/src/sclite/makefile.in
+++ b/src/sclite/makefile.in
@@ -193,7 +193,7 @@ uninstall:
 	done
 
 config.sh: config.in
-	cd $(srcdir) && /usr/local/bin/autoconf config.in | sed 's/Makefile/makefile/g' > config.sh
+	cd $(srcdir) && autoconf config.in | sed 's/Makefile/makefile/g' > config.sh
 
 # autoheader might not change config.hin.
 config.hin: stamp-h.in
