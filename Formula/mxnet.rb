class Mxnet < Formula
  desc "Lightweight, Portable, Flexible Distributed/Mobile Deep Learning"
  homepage "https://mxnet.apache.org/"
  version "1.7.0"
  url "https://github.com/apache/incubator-mxnet.git", tag: "#{version}"
  head "https://github.com/apache/incubator-mxnet"
  license "Apache"

  depends_on "cmake" => :build
  depends_on "mkl"
  on_linux do
    depends_on "cuda11"
    depends_on "cudnn11"
    depends_on "nccl"
  end
  on_macos do
    uses_from_macos "python@3"
  end

  patch :DATA

  def install
    rm_r "3rdparty/openmp"
    rm_r "3rdparty/nvidia_cub"
    args = [
      "-DUSE_MKLDNN=1",
      "-DUSE_CPP_PACKAGE=1", # gone in 2.0.0
      "-DINSTALL_EXAMPLES=1"
    ]
    on_linux do
      args += [
        "-DUSE_CUDA=1",
        "-DUSE_NCCL=1",
        "-DUSE_CUDNN=1",
        "-DMXNET_CUDA_ARCH=3.7 6.1 7.0 7.5 8.6+PTX"
      ]
    end
    on_macos do
      args += [
        # OpenMP and OpenCV could work, they just have a lot of deps
        "-DPYTHON_EXECUTABLE=/usr/bin/python3",
        "-DUSE_CUDA=0",
        "-DUSE_OPENMP=0",
        "-DUSE_OPENCV=0"
      ]
    end

    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "false"
  end
end

__END__
diff --git a/cpp-package/CMakeLists.txt b/cpp-package/CMakeLists.txt
index fec86e78e..d3e46200f 100644
--- a/cpp-package/CMakeLists.txt
+++ b/cpp-package/CMakeLists.txt
@@ -12,7 +12,7 @@ if(USE_CPP_PACKAGE)
     MAIN_DEPENDENCY mxnet
     DEPENDS mxnet ${CMAKE_CURRENT_SOURCE_DIR}/scripts/OpWrapperGenerator.py
     COMMAND echo "Running: OpWrapperGenerator.py"
-    COMMAND python OpWrapperGenerator.py $<TARGET_FILE:mxnet>
+    COMMAND python3 OpWrapperGenerator.py $<TARGET_FILE:mxnet>
     WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/scripts
   )
 
diff --git a/cpp-package/cpp-package.mk b/cpp-package/cpp-package.mk
index b9e7c3331..f9d83c423 100644
--- a/cpp-package/cpp-package.mk
+++ b/cpp-package/cpp-package.mk
@@ -36,10 +36,10 @@ cpp-package-clean:
 	rm -f $(CPP_PACKAGE_OP_H_FILE)
 
 $(CPP_PACKAGE_OP_H_FILE): lib/libmxnet.so cpp-package/scripts/OpWrapperGenerator.py
-	(cd cpp-package/scripts; python OpWrapperGenerator.py $(ROOTDIR)/lib/libmxnet.so)
+	(cd cpp-package/scripts; python3 OpWrapperGenerator.py $(ROOTDIR)/lib/libmxnet.so)
 
 cpp-package-lint:
-	(cd cpp-package; python scripts/lint.py dmlc ${LINT_LANG} include example)
+	(cd cpp-package; python3 scripts/lint.py dmlc ${LINT_LANG} include example)
 
 include cpp-package/example/example.mk
 include cpp-package/example/inference/inference.mk
