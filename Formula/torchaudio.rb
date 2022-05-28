class Torchaudio < Formula
  desc "An audio library for PyTorch"
  homepage "https://pytorch.org/audio/stable/index.html"
  version "0.11.0"
  url "https://github.com/pytorch/audio.git", tag: "v#{version}"
  head "https://github.com/pytorch/audio.git"
  license "BSD-2-Clause"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "pytorch"

  # patch against the updated zlib (later versions use github)
  patch :DATA

  if Formula["cuda"].optlinked? then
    depends_on "cuda"
    depends_on "cudnn"
  end

  def install
    ENV["USE_OPENMP"] = "ON"
    if Formula["cuda"].optlinked? then
      ENV["USE_CUDA"] = "ON"
      ENV["TORCH_CUDA_ARCH_LIST"] = "3.7;6.1;7.0;7.5;8.6+PTX"
    end

    system "python3", *Language::Python.setup_install_args(prefix)    
  end

  test do
    system "false"
  end
end

__END__
diff --git a/third_party/zlib/CMakeLists.txt b/third_party/zlib/CMakeLists.txt
index c305edc1..3022215c 100644
--- a/third_party/zlib/CMakeLists.txt
+++ b/third_party/zlib/CMakeLists.txt
@@ -22,8 +22,8 @@ set(
 ExternalProject_Add(zlib-
   PREFIX ${CMAKE_CURRENT_BINARY_DIR}
   DOWNLOAD_DIR ${ARCHIVE_DIR}
-  URL https://zlib.net/zlib-1.2.11.tar.gz
-  URL_HASH SHA256=c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1
+  URL https://zlib.net/zlib-1.2.12.tar.gz
+  URL_HASH SHA256=91844808532e5ce316b3c010929493c0244f3d37593afd6de04f71821d5136d9
   BUILD_BYPRODUCTS ${ZLIB_LIBRARIES}
   CONFIGURE_COMMAND ${CMAKE_COMMAND} -E env ${envs} ${CMAKE_CURRENT_BINARY_DIR}/src/zlib-/configure --static
   BUILD_COMMAND ${CMAKE_COMMAND} -E env ${envs} make VERBOSE=1
