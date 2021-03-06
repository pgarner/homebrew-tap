class PfileUtils < Formula
  desc "ICSI's PFile utilities"
  homepage "http://www1.icsi.berkeley.edu/Speech/icsi-speech-tools.html"
  version "v0_51"
  url "ftp://ftp.icsi.berkeley.edu/pub/real/davidj/pfile_utils-#{version}.tar.gz"
  sha256 "197c6c1f4eb11ec82cf47ca49fd8c8c18641a7ab0322144e72a49341d5fdec85"
  license "BSD (probably)"

  depends_on "quicknet"

  patch :DATA

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
    ]
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "false"
  end
end

__END__
diff -Naur pfile_utils-v0_51.orig/eig.c pfile_utils-v0_51/eig.c
--- pfile_utils-v0_51.orig/eig.c	2008-05-12 19:37:18.000000000 +0200
+++ pfile_utils-v0_51/eig.c	2018-01-08 14:57:10.106837000 +0100
@@ -10,6 +10,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <math.h>
+#include <string.h>
 
 #define SQR(a) ((a)*(a))
 #define SIGN(a,b) ((b) >= 0.0 ? fabs(a) : -fabs(a))
diff -Naur pfile_utils-v0_51.orig/error.cc pfile_utils-v0_51/error.cc
--- pfile_utils-v0_51.orig/error.cc	2008-05-12 19:37:18.000000000 +0200
+++ pfile_utils-v0_51/error.cc	2018-01-08 14:57:10.113838000 +0100
@@ -15,7 +15,7 @@
 #include "error.h"
 
 void
-error(char *format, ...)
+error(const char *format, ...)
 {
   va_list ap;
   va_start(ap,format);
diff -Naur pfile_utils-v0_51.orig/error.h pfile_utils-v0_51/error.h
--- pfile_utils-v0_51.orig/error.h	2008-05-12 19:37:18.000000000 +0200
+++ pfile_utils-v0_51/error.h	2018-01-08 14:57:10.119837000 +0100
@@ -25,6 +25,6 @@
 #define EXIT_FAILURE (1)
 #endif
 
-void error(char *format, ...);
+void error(const char *format, ...);
 
 #endif
diff -Naur pfile_utils-v0_51.orig/ilab_create.cc pfile_utils-v0_51/ilab_create.cc
--- pfile_utils-v0_51.orig/ilab_create.cc	2008-05-12 19:37:18.000000000 +0200
+++ pfile_utils-v0_51/ilab_create.cc	2018-01-08 14:57:10.127842000 +0100
@@ -116,14 +116,14 @@
     qn_btoh_vi32_vi32(n_labs, 
 		   (QNInt32*) labs, (QNInt32*) labs);
   } else {
-    if (fscanf(in_fp,"%u",&sent_no) == EOF) {
+    if (fscanf(in_fp,"%zu",&sent_no) == EOF) {
       if (feof(in_fp)) {
 	return false; // eof found
       } else {
 	error("ERROR: format error input. Expecting sentence number.");
       }
     } 
-    if (fscanf(in_fp,"%u",&frame_no) == EOF) {
+    if (fscanf(in_fp,"%zu",&frame_no) == EOF) {
       error("ERROR: format error input. Expecting frame number.");
     } 
     size_t i;
diff -Naur pfile_utils-v0_51.orig/linalg.h pfile_utils-v0_51/linalg.h
--- pfile_utils-v0_51.orig/linalg.h	2008-05-12 19:37:18.000000000 +0200
+++ pfile_utils-v0_51/linalg.h	2018-01-08 14:59:42.626452000 +0100
@@ -11,8 +11,8 @@
 class linalg {
  public:
   // some useful constants
-  static const double tiny = 1.0e-20;
-  static const double epsilon = 0.0000001;
+  static constexpr double tiny = 1.0e-20;
+  static constexpr double epsilon = 0.0000001;
 
   // the static methods
   static void ludcmp(icsiarray<double>&, const int, icsiarray<int>&, float*);
diff -Naur pfile_utils-v0_51.orig/pfile_build.cc pfile_utils-v0_51/pfile_build.cc
--- pfile_utils-v0_51.orig/pfile_build.cc	2008-05-12 19:37:18.000000000 +0200
+++ pfile_utils-v0_51/pfile_build.cc	2018-01-08 14:57:10.134836000 +0100
@@ -258,7 +258,7 @@
     while ((sent_id = sent_id_stream.next()))
     {
       if (!quiet)
-        printf("Processing sentence %s (#%d).\n", 
+        printf("Processing sentence %s (#%zd).\n", 
 		sent_id,sent_id_stream.number_read());
 
         // Get FEAT for this sentence.
@@ -465,7 +465,7 @@
 		quiet);
 
     if (!quiet)
-      printf("Processed %d labels total.\n",
+      printf("Processed %zd labels total.\n",
 	     label_vals_stream_p->labels_read());
 
     //////////////////////////////////////////////////////////////////////
diff -Naur pfile_utils-v0_51.orig/pfile_concat.cc pfile_utils-v0_51/pfile_concat.cc
--- pfile_utils-v0_51.orig/pfile_concat.cc	2008-05-12 19:37:18.000000000 +0200
+++ pfile_utils-v0_51/pfile_concat.cc	2018-01-08 14:57:10.142836000 +0100
@@ -124,7 +124,7 @@
 	    // Check that this input pfile is the same size as predecessors
 	    if (in_stream->num_labs() != n_labs \
 		|| in_stream->num_ftrs() != n_ftrs) {
-		sprintf(errmsg, "Features/labels of %s (%d/%d) don't match first input file (%d/%d)", pfile_name, in_stream->num_labs(), in_stream->num_ftrs(), n_labs, n_ftrs);
+		sprintf(errmsg, "Features/labels of %s (%zd/%zd) don't match first input file (%ld/%ld)", pfile_name, in_stream->num_labs(), in_stream->num_ftrs(), n_labs, n_ftrs);
 		error(errmsg);
 	    }
 	}
diff -Naur pfile_utils-v0_51.orig/pfile_create.cc pfile_utils-v0_51/pfile_create.cc
--- pfile_utils-v0_51.orig/pfile_create.cc	2008-05-12 19:37:18.000000000 +0200
+++ pfile_utils-v0_51/pfile_create.cc	2018-01-08 14:57:10.150836000 +0100
@@ -122,14 +122,14 @@
     }
     qn_btoh_vi32_vi32(n_labs, (QNInt32*) labs, (QNInt32*) labs);
   } else {
-    if (fscanf(in_fp,"%u",&sent_no) == EOF) {
+    if (fscanf(in_fp,"%zu",&sent_no) == EOF) {
       if (feof(in_fp)) {
 	return false; // eof found
       } else {
 	error("ERROR: format error input. Expecting sentence number.");
       }
     } 
-    if (fscanf(in_fp,"%u",&frame_no) == EOF) {
+    if (fscanf(in_fp,"%zu",&frame_no) == EOF) {
       error("ERROR: format error input. Expecting frame number.");
     } 
     size_t i;
diff -Naur pfile_utils-v0_51.orig/pfile_gaussian.cc pfile_utils-v0_51/pfile_gaussian.cc
--- pfile_utils-v0_51.orig/pfile_gaussian.cc	2008-05-12 19:37:18.000000000 +0200
+++ pfile_utils-v0_51/pfile_gaussian.cc	2018-01-08 14:57:10.159836000 +0100
@@ -354,7 +354,7 @@
 
 	for (i=0;i<frrng.length();i++) {
 	    double maxs_stds, mins_stds;
-	    rc = fscanf(in_st_fp,"%d %lf %lf %f %d %d %f %d %d %lf %lf ",&j,
+	    rc = fscanf(in_st_fp,"%d %lf %lf %f %zd %zd %f %zd %zd %lf %lf ",&j,
 		    ftr_means_p,ftr_stds_p,
 		    ftr_maxs_p,
 		    &ftr_maxs_locs_p->sent_no,&ftr_maxs_locs_p->frame_no,
@@ -363,7 +363,7 @@
 		    &maxs_stds,&mins_stds);
 	    if (rc != 11 || j != i) {
 		fprintf(stderr,
-		       "%s: Error reading input stats file in lead-in %d.\n",
+		       "%s: Error reading input stats file in lead-in %zd.\n",
 		       program_name, i);
 		error("Aborting.");
 	    }
@@ -372,10 +372,10 @@
 	    if (hist_bins > 0) {
 		hist_tot = 0;
 		for (j=0;j<hist_bins;j++) {
-		    if (fscanf(in_st_fp,"%d ", hist_p) != 1) {
+		    if (fscanf(in_st_fp,"%zd ", hist_p) != 1) {
 			fprintf(stderr,
 				"%s: Error reading input stats file, "
-				"el %d bin %d.\n",
+				"el %zd bin %d.\n",
 				program_name, i, j);
 			error("Aborting.");
 		    }
@@ -383,8 +383,8 @@
 		}
 		if (last_hist_tot != -1 && hist_tot != last_hist_tot) {
 		    fprintf(stderr, 
-			    "%s: Error reading histogram: for for el %d had "
-			    "%d entries, %d had %d\n", program_name, 
+			    "%s: Error reading histogram: for for el %zd had "
+			    "%d entries, %zd had %d\n", program_name, 
 			    i, hist_tot, i-1, last_hist_tot);
 		    error("Aborting.");
 		}
@@ -639,14 +639,14 @@
       for (i=0;i<frrng.length();i++) {
 	const double maxs_stds = (*ftr_maxs_p)/(*ftr_stds_p);
 	const double mins_stds = (*ftr_mins_p)/(*ftr_stds_p);
-	fprintf(out_st_fp,"%d %g %g %g %d %d %g %d %d %g %g ",i,
+	fprintf(out_st_fp,"%zd %g %g %g %zd %zd %g %zd %zd %g %g ",i,
 		*ftr_means_p,*ftr_stds_p,
 		*ftr_maxs_p,ftr_maxs_locs_p->sent_no,ftr_maxs_locs_p->frame_no,
 		*ftr_mins_p,ftr_mins_locs_p->sent_no,ftr_mins_locs_p->frame_no,
 		maxs_stds,mins_stds);
 	if (hist_bins > 0) {
 	  for (j=0;j<hist_bins;j++) {
-	    fprintf(out_st_fp,"%d ",*hist_p++);
+	    fprintf(out_st_fp,"%zd ",*hist_p++);
 	  }
 	}
 	fprintf(out_st_fp,"\n");
diff -Naur pfile_utils-v0_51.orig/pfile_info.cc pfile_utils-v0_51/pfile_info.cc
--- pfile_utils-v0_51.orig/pfile_info.cc	2008-05-12 19:37:18.000000000 +0200
+++ pfile_utils-v0_51/pfile_info.cc	2018-01-08 14:57:10.166836000 +0100
@@ -108,7 +108,7 @@
 
     if (!dont_print_info) {
       fprintf(out_fp,"%s\n",input_fname);
-      fprintf(out_fp,"%d sentences, %d frames, %d label(s), %d features\n",
+      fprintf(out_fp,"%zd sentences, %zd frames, %zd label(s), %zd features\n",
 	      in_streamp->num_segs(),
 	      in_streamp->num_frames(),
 	      in_streamp->num_labs(),
@@ -119,7 +119,7 @@
       for (size_t next_sent = 0; next_sent < in_streamp->num_segs(); 
 	   next_sent++ ) {
 	const size_t n_frames = in_streamp->num_frames(next_sent);
-	fprintf(out_fp,"%d %d\n",next_sent,n_frames);
+	fprintf(out_fp,"%zd %zd\n",next_sent,n_frames);
       }
     }
 
diff -Naur pfile_utils-v0_51.orig/pfile_initmg.cc pfile_utils-v0_51/pfile_initmg.cc
--- pfile_utils-v0_51.orig/pfile_initmg.cc	2008-05-12 19:37:18.000000000 +0200
+++ pfile_utils-v0_51/pfile_initmg.cc	2018-01-08 14:57:10.175836000 +0100
@@ -544,7 +544,7 @@
 
 	  if (!quiet_mode) {
 	    if ((sent_no) % 1000 == 0)
-	      printf("Processing sentence %d\n",(sent_no));
+	      printf("Processing sentence %zd\n",(sent_no));
 	  }
 
 	  if (n_frames == QN_SIZET_BAD)
@@ -677,7 +677,7 @@
 
 	if (!quiet_mode) {
 	  if ((sent_no) % 1000 == 0)
-	    printf("Processing sentence %d\n",(sent_no));
+	    printf("Processing sentence %zd\n",(sent_no));
 	}
 
 	if (n_frames == QN_SIZET_BAD)
diff -Naur pfile_utils-v0_51.orig/pfile_mi.cc pfile_utils-v0_51/pfile_mi.cc
--- pfile_utils-v0_51.orig/pfile_mi.cc	2008-05-12 19:37:19.000000000 +0200
+++ pfile_utils-v0_51/pfile_mi.cc	2018-01-08 14:57:10.188841000 +0100
@@ -1530,7 +1530,7 @@
       em_iter ++;
 
       if ((time(0)-timeOfLastPrint) > NUM_SECONDS_PER_PRINT) {
-	printf("Iter %d: Starting Iter\n",em_iter);
+	printf("Iter %zd: Starting Iter\n",em_iter);
 	fflush(stdout);
 	timeOfLastPrint = time(0);
       }
@@ -1548,7 +1548,7 @@
 	const size_t n_frames = in_streamp->num_frames((*srit));
 
 	if ((time(0)-timeOfLastPrint) > NUM_SECONDS_PER_PRINT) {
-	    printf("Iter %d, sentence %d\n",em_iter,(*srit));
+	    printf("Iter %zd, sentence %d\n",em_iter,(*srit));
 	    fflush(stdout);
 	    timeOfLastPrint = time(0);
 	}
@@ -1733,7 +1733,7 @@
 
       mbn.endEpoch();
       if ((time(0)-timeOfLastPrint) > NUM_SECONDS_PER_PRINT) {
-	printf("Iter %d: Finished Iter\n",em_iter);
+	printf("Iter %zd: Finished Iter\n",em_iter);
 	fflush(stdout);
 	timeOfLastPrint = time(0);
       }
@@ -1747,7 +1747,7 @@
 
       if ((numActive < prevNumActive) || 
 	  ((time(0) - timeOfLastPrintNumActive) > MINTIMEPERPRINTNUMACTIVE)) {
-	printf("Iter %d: NA=%d/%d(%.0f%%), PNA=%d, dist Max(%e) Avg(%e) Min(%e)\n",
+	printf("Iter %zd: NA=%d/%ld(%.0f%%), PNA=%d, dist Max(%e) Avg(%e) Min(%e)\n",
 	       em_iter,
 	       numActive,n_mis,100*numActive/(double)n_mis,
 	       prevNumActive,
@@ -1765,7 +1765,7 @@
         // the middle
 	// of saving the parameters. So, instead of saving, we forfeit
 	// the work done during this em_iter for safety's sake.
-	printf("Iter %d: Not Saving Mixture Parameters Since Received SIGUSR2.\n",em_iter); fflush(stdout);
+	printf("Iter %zd: Not Saving Mixture Parameters Since Received SIGUSR2.\n",em_iter); fflush(stdout);
       } else if (po_fp != NULL && 
 		 ((numActive+nacps <= prevNumActive) ||
 		  (numActive == num_active_to_stop) ||
@@ -1780,7 +1780,7 @@
     delete counts;
 
     if (usr2_terminate) {
-      printf("Iter %d: Exiting early with failure due to received SIGUSR2\n",em_iter);
+      printf("Iter %zd: Exiting early with failure due to received SIGUSR2\n",em_iter);
       exit (EXIT_FAILURE);
     }
 
@@ -1794,7 +1794,7 @@
       printf("Finished computing Mutual Information\n");
       fflush(stdout);
     } else {
-      printf("Early stop at EM iter %d, Num Active=%d, not computing MI\n",
+      printf("Early stop at EM iter %zd, Num Active=%d, not computing MI\n",
 	     em_iter,numActive);
     }
 
diff -Naur pfile_utils-v0_51.orig/pfile_norm.cc pfile_utils-v0_51/pfile_norm.cc
--- pfile_utils-v0_51.orig/pfile_norm.cc	2008-05-12 19:37:19.000000000 +0200
+++ pfile_utils-v0_51/pfile_norm.cc	2018-01-08 14:57:10.196836000 +0100
@@ -364,7 +364,7 @@
     char *buf;
     int bufpos;
     int linect;
-    static char *WS;
+    static const char *WS;
 
     tokFile(FILE* a_file, const char *a_name = "(unknown)") {
         file = a_file;
@@ -386,7 +386,7 @@
         fclose(file);
     }
 };
-char *tokFile::WS = " \t\n";
+const char *tokFile::WS = " \t\n";
 
 int tokFile::getNextTok(char **ret) {
     // Pull another space-delimited token from an open file handle.
@@ -413,7 +413,7 @@
             delete [] buf;
             buf = newbuf;
             buflen = newbuflen;
-            fgets(buf+got, buflen-got, file);
+            char *dummy = fgets(buf+got, buflen-got, file);
             got = strlen(buf);
         }
         ++linect;
diff -Naur pfile_utils-v0_51.orig/pfile_patchlabels.cc pfile_utils-v0_51/pfile_patchlabels.cc
--- pfile_utils-v0_51.orig/pfile_patchlabels.cc	2008-05-12 19:37:19.000000000 +0200
+++ pfile_utils-v0_51/pfile_patchlabels.cc	2018-01-08 14:57:10.203836000 +0100
@@ -18,6 +18,7 @@
 #include "QN_PFile.h"
 #include "QN_camfiles.h"
 #include "QN_ILab.h"
+#include "error.h"
 
 /* Patch broken header files. */
 
@@ -41,22 +42,6 @@
 
 static const char* program_name;
 
-static void
-error(char *format, ...)
-{
-  va_list ap;
-  va_start(ap,format);
-  /* print out remainder of message */
-  (void) vfprintf(stderr, format, ap);
-  va_end(ap);
-  (void) fprintf(stderr, "\n");
-  (void) exit(EXIT_FAILURE);
-}
-
-
-
-
-
 
 static void
 usage(const char* message = 0)
@@ -82,7 +67,7 @@
 }
 
 static long
-parse_long(const char*const s)
+parse_long(const char* s)
 {
     size_t len = strlen(s);
     char *ptr;
@@ -650,7 +635,7 @@
 	    *in_stream_p,
 	    *out_stream_p);
 
-    fprintf(stderr,"Processed %d labels total.\n",
+    fprintf(stderr,"Processed %zd labels total.\n",
 	    label_vals_stream_p->labels_read());
 
     //////////////////////////////////////////////////////////////////////
diff -Naur pfile_utils-v0_51.orig/pfile_print.cc pfile_utils-v0_51/pfile_print.cc
--- pfile_utils-v0_51.orig/pfile_print.cc	2008-05-12 19:37:19.000000000 +0200
+++ pfile_utils-v0_51/pfile_print.cc	2018-01-08 14:57:10.209836000 +0100
@@ -50,7 +50,7 @@
 	    "-pr <range>     per-sentence range\n"
 	    "-lr <range>     label range\n"
 	    "-b              print raw binary data (ints and floats)\n"
-	    "-ff             use %f for ascii output rather than %g\n"
+	    "-ff             use %%f for ascii output rather than %%g\n"
             "-ns             Don't print the frame IDs (i.e., sent and frame #)\n"
 	    "-debug <level>  number giving level of debugging output to produce 0=none.\n"
     );
diff -Naur pfile_utils-v0_51.orig/pfile_skmeans.cc pfile_utils-v0_51/pfile_skmeans.cc
--- pfile_utils-v0_51.orig/pfile_skmeans.cc	2008-05-12 19:37:19.000000000 +0200
+++ pfile_utils-v0_51/pfile_skmeans.cc	2018-01-08 14:57:10.220836000 +0100
@@ -580,7 +580,7 @@
 
 	  if (!quiet_mode) {
 	    if ((sent_no) % SENTS_PER_PRINT == 0)
-	      printf("Processing sentence %d\n",(sent_no));
+	      printf("Processing sentence %zd\n",(sent_no));
 	  }
 
 	  if (n_frames == QN_SIZET_BAD)
@@ -743,7 +743,7 @@
 
 	if (!quiet_mode) {
 	  if ((sent_no) % SENTS_PER_PRINT == 0)
-	    printf("Processing sentence %d\n",(sent_no));
+	    printf("Processing sentence %zd\n",(sent_no));
 	}
 
 	if (n_frames == QN_SIZET_BAD)
@@ -923,7 +923,7 @@
 
 	  if (!quiet_mode) {
 	    if ((sent_no) % 1 == 0)
-	      printf("Processing sentence %d\n",(sent_no));
+	      printf("Processing sentence %zd\n",(sent_no));
 	  }
 
 	  if (n_frames == QN_SIZET_BAD)
@@ -1096,7 +1096,7 @@
 
 	if (!quiet_mode) {
 	  if ((sent_no) % SENTS_PER_PRINT == 0)
-	    printf("Processing sentence %d\n",(sent_no));
+	    printf("Processing sentence %zd\n",(sent_no));
 	}
 
 	if (n_frames == QN_SIZET_BAD)
diff -Naur pfile_utils-v0_51.orig/pfile_stats.cc pfile_utils-v0_51/pfile_stats.cc
--- pfile_utils-v0_51.orig/pfile_stats.cc	2008-05-12 19:37:19.000000000 +0200
+++ pfile_utils-v0_51/pfile_stats.cc	2018-01-08 14:57:10.227836000 +0100
@@ -312,14 +312,14 @@
     for (i=0;i<frrng.length();i++) {
       const double maxs_stds = (*ftr_maxs_p)/(*ftr_stds_p);
       const double mins_stds = (*ftr_mins_p)/(*ftr_stds_p);
-      fprintf(out_fp,"%d %g %g %g %d %d %g %d %d %g %g ",i,
+      fprintf(out_fp,"%zd %g %g %g %zd %zd %g %zd %zd %g %g ",i,
 	     *ftr_means_p,*ftr_stds_p,
 	     *ftr_maxs_p,ftr_maxs_locs_p->sent_no,ftr_maxs_locs_p->frame_no,
 	     *ftr_mins_p,ftr_mins_locs_p->sent_no,ftr_mins_locs_p->frame_no,
 	     maxs_stds,mins_stds);
       if (hist_bins > 0) {
 	for (j=0;j<hist_bins;j++) {
-	  fprintf(out_fp,"%d ",*hist_p++);
+	  fprintf(out_fp,"%zd ",*hist_p++);
 	}
       }
       fprintf(out_fp,"\n");
@@ -336,7 +336,7 @@
 	min_mins_stds = mins_stds;
     }
     if (!quiet_mode) {
-      printf("total sents used = %d, total frames used = %d\n",
+      printf("total sents used = %d, total frames used = %zd\n",
 	      srrng.length(),total_frames);
       printf("max_maxs_stds = %f, min_mins_stds = %f\n",
 	     max_maxs_stds,min_mins_stds);
diff -Naur pfile_utils-v0_51.orig/Range.C pfile_utils-v0_51/Range.C
--- pfile_utils-v0_51.orig/Range.C	2008-05-12 19:37:18.000000000 +0200
+++ pfile_utils-v0_51/Range.C	2018-01-08 14:57:10.236836000 +0100
@@ -614,7 +614,7 @@
     fprintf(stderr, "Range::Parse error: %s\n", errmsg);
     fprintf(stderr, ">> %s\n", def_str);
     char fmtstr[32];
-    sprintf(fmtstr, ">> %%%ds\n", (pos-def_str));
+    sprintf(fmtstr, ">> %%%lds\n", (pos-def_str));
     fprintf(stderr, fmtstr, "^");
 }
 
@@ -842,7 +842,7 @@
     static int bufpos = 0;
     static int bufline = 0; */
 
-    char *WS = " \t\n\r";
+    const char *WS = " \t\n\r";
 
     if (buf == NULL) {
 	buf = new char[buflen];
@@ -868,7 +868,7 @@
 	    delete [] buf;
 	    buf = newbuf;
 	    buflen = newbuflen;
-	    fgets(buf+got, buflen, file_handle);
+	    char *dummy = fgets(buf+got, buflen, file_handle);
 	    got = strlen(buf);
 	}
 	++bufline;
diff -Naur pfile_utils-v0_51.orig/Range.H pfile_utils-v0_51/Range.H
--- pfile_utils-v0_51.orig/Range.H	2008-05-12 19:37:18.000000000 +0200
+++ pfile_utils-v0_51/Range.H	2018-01-08 14:57:10.243836000 +0100
@@ -116,7 +116,7 @@
     char *pos;			// global for roach-parsing string
     int min_val;		// lower bound defined for string
     int max_val;		// upper bound defined for string
-    char *errmsg;		// message describing parse error
+    const char *errmsg;		// message describing parse error
 
     RangeList rangeList;	// The root of the range list
 
