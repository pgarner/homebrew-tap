class Irstlm < Formula
  desc "The IRST language modelling toolkit"
  homepage "https://github.com/irstlm-team/irstlm"
  head "https://github.com/irstlm-team/irstlm"
  version "6.00.05"
  url "https://github.com/irstlm-team/irstlm/archive/v#{version}.tar.gz"
  sha256 ""
  license "LGPL"

  depends_on "cmake" => :build

  patch :DATA

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    system "false"
  end
end

__END__
diff --git a/src/CMakeLists.txt b/src/CMakeLists.txt
index 9722cae..e1abee6 100644
--- a/src/CMakeLists.txt
+++ b/src/CMakeLists.txt
@@ -29,7 +29,7 @@ else()
   ADD_DEFINITIONS("-UHAVE_CXX0")
 endif() 
 
-SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g ${STD_FLAG} -isystem/usr/include -W -Wall -ffor-scope")
+SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g ${STD_FLAG} -W -Wall -ffor-scope")
 SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}")
 
 INCLUDE_DIRECTORIES("${PROJECT_SOURCE_DIR}/src")
