class BrnoStk < Formula
  desc "The Brno speech recognition toolkit"
  homepage "https://github.com/stk-developers/stk"
  url "https://github.com/stk-developers/stk.git", revision: "1e9c49b"
  version "2018.04"
  license "GPL-2.0"

  patch :DATA

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --enable-sse
      --without-atlas
    ]
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "false"
  end
end

__END__
diff --git a/src/STKLib/Models.cc b/src/STKLib/Models.cc
index c79b852..c4a8a79 100644
--- a/src/STKLib/Models.cc
+++ b/src/STKLib/Models.cc
@@ -1099,7 +1099,7 @@ namespace STK
   
     if (mask & MTM_HMM && !(mask & MTM_PRESCAN)) 
     {
-      if (n > 0) chptr = '\0';
+      if (n > 0) chptr = 0;
       action(mt_hmm, nodeName, this, pUserData);
     }
   }
@@ -1571,7 +1571,7 @@ namespace STK
     }
   
     if (mask & MTM_MIXTURE && !(mask & MTM_PRESCAN)) {
-      if (n > 0) chptr = '\0';
+      if (n > 0) chptr = 0;
       action(mt_mixture, nodeName, this, pUserData);
     }
   }
@@ -2278,7 +2278,7 @@ namespace STK
     }
     if (mask & MTM_STATE && !(mask & MTM_PRESCAN)) 
     {
-      if (n > 0) chptr = '\0';
+      if (n > 0) chptr = 0;
       action(mt_state, nodeName, this, pUserData);
     }
   }
@@ -2386,7 +2386,7 @@ namespace STK
     }
     
     if (mask & MTM_XFORM_INSTANCE && !(mask & MTM_PRESCAN)) {
-      if (n > 0) chptr = '\0';
+      if (n > 0) chptr = 0;
       action(mt_XformInstance, nodeName, this, pUserData);
     }
   }
@@ -2466,7 +2466,7 @@ namespace STK
     if (!(mask & MTM_PRESCAN)) 
     {
       if (n > 0) 
-        chptr = '\0';
+        chptr = 0;
         
       action(mt_Xform, nodeName, this, pUserData);
     }
