class Sph2pipe < Formula
  desc "Sphere to pipe"
  homepage "http://www.openslr.org"
  url "http://www.openslr.org/resources/3/sph2pipe_v2.5.tar.gz"
  sha256 "5be236dc94ed0a301c5c8a369f849f76799ec7e70f25dfc0521068d9d1d4d3e3"
  license "SoftSound / SoX"

  depends_on "cmake" => :build

  patch :DATA

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    pkgshare.install "test"
  end

  test do
    system "false"
  end
end

__END__
--- sph2pipe_org/CMakeLists.txt	1970-01-01 01:00:00.000000000 +0100
+++ sph2pipe_v2.5/CMakeLists.txt	2020-12-30 13:43:21.290899542 +0100
@@ -0,0 +1,8 @@
+project(sph2pipe)
+cmake_minimum_required(VERSION 3.9)
+set(CMAKE_C_STANDARD 90)
+add_executable(sph2pipe file_headers.c shorten_x.c sph2pipe.c)
+target_link_libraries(sph2pipe m)
+install(TARGETS sph2pipe
+  RUNTIME DESTINATION bin
+)
