class CmudictTools < Formula
  desc "CMU Pronunciation Dictionary Tools"
  homepage "https://github.com/rhdunn/cmudict-tools"
  version "2017-05"
  url "https://github.com/rhdunn/cmudict-tools.git", revision: "fe97e68"
  license "GPL-3.0"

  on_macos do
    uses_from_macos "python@3"
    depends_on "pandoc"
  end

  patch :DATA

  def install
    # The things that pip installs as deps
    xy = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH",
      "#{prefix}/lib/python#{xy}/site-packages"

    system "make", "README.rst"
    system "pip3", "-v", "install", "--prefix", "#{prefix}", "rdflib"
    system "pip3", "-v", "install", "--prefix", "#{prefix}", "."
  end

  test do
    system "false"
  end
end

__END__
diff --git a/cmudicttools/cmudict.py b/cmudicttools/cmudict.py
index fe6fc4d..4469d51 100644
--- a/cmudicttools/cmudict.py
+++ b/cmudicttools/cmudict.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 # coding=utf-8
 #
 # Tool for processing the CMU Pronunciation Dictionary file formats.
diff --git a/cmudicttools/metadata.py b/cmudicttools/metadata.py
index 6773c27..575c1a9 100644
--- a/cmudicttools/metadata.py
+++ b/cmudicttools/metadata.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 # coding=utf-8
 #
 # Metadata Description File parser.
diff --git a/setup.py b/setup.py
index 0bbab70..8951200 100755
--- a/setup.py
+++ b/setup.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 # coding=utf-8
 #
 # cmudict-tools setup script
