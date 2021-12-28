class Magma < Formula
  desc "Matrix Algebra on GPU and Multicore Architectures"
  homepage "https://icl.utk.edu/magma/index.html"
  version "2.6.1"
  url "http://icl.utk.edu/projectsfiles/magma/downloads/magma-#{version}.tar.gz"
  sha256 "6cd83808c6e8bc7a44028e05112b3ab4e579bcc73202ed14733f66661127e213"
  license "BSD"

  # Magma actually requires *both* a CPU and GPU, hence cuda (or the AMD
  # equivalent); so not MacOS for the moment

  depends_on :linux
  depends_on "cmake" => :build
  depends_on "mkl"
  depends_on "cuda11"

  # Patch is taken from Arch Linux
  patch :DATA

  def install
    ENV["MKLROOT"] = "#{HOMEBREW_PREFIX}"
    args = [
      # We actually want: 3.7;6.1;7.0;7.5;8.6+PTX
      "-DGPU_TARGET=sm_35 sm_61 sm_70 sm_75 sm_80 sm_86"
    ]
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "false"
  end
end

__END__
diff --color -aur magma-2.6.1-old/CMakeLists.txt magma-2.6.1-new/CMakeLists.txt
--- magma-2.6.1-old/CMakeLists.txt      2021-07-13 01:35:20.000000000 +0300
+++ magma-2.6.1-new/CMakeLists.txt      2021-07-21 11:02:28.014236200 +0300
@@ -294,6 +294,15 @@
         message( STATUS "    compile for CUDA arch 8.0 (Ampere)" )
     endif()
 
+    if (GPU_TARGET MATCHES sm_86)
+        if (NOT MIN_ARCH)
+            set( MIN_ARCH 860 )
+        endif()
+        set( NV_SM ${NV_SM} -gencode arch=compute_86,code=sm_86 )
+        set( NV_COMP        -gencode arch=compute_86,code=compute_86 )
+        message( STATUS "    compile for CUDA arch 8.6 (Ampere)" )
+    endif()
+
     if (NOT MIN_ARCH)
         message( FATAL_ERROR "GPU_TARGET must contain one or more of Fermi, Kepler, Maxwell, Pascal, Volta, Turing, Ampere, or valid sm_[0-9][0-9]" )
     endif()
