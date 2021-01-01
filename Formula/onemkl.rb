#
# The installer contains these packages:
#
# intel.oneapi.lin.mkl.product,v=2021.1.1-52
# intel.oneapi.lin.mkl.devel,v=2021.1.1-52
# intel.oneapi.lin.mkl.runtime,v=2021.1.1-52
# intel.oneapi.lin.oneapi-common.vars,v=2021.1.1-60
# intel.oneapi.lin.oneapi-common.licensing,v=2021.1.1-60
# intel.oneapi.lin.tbb.runtime,v=2021.1.1-119
# intel.oneapi.lin.condaindex,v=2021.1.1-58
# intel.oneapi.lin.dpcpp-cpp-common.runtime,v=2021.1.1-189
# intel.oneapi.lin.compilers-common.runtime,v=2021.1.1-189
# intel.oneapi.lin.openmp,v=2021.1.1-189
#
class Onemkl < Formula
  desc "Intel oneAPI Math Kernel Library"
  homepage "https://software.intel.com/content/www/us/en/develop/tools/oneapi.html"
  version "2021.1.1.52"
  url "https://registrationcenter-download.intel.com/akdlm/irc_nas/17402/l_onemkl_p_#{version}_offline.sh"
  sha256 "818b6bd9a6c116f4578cda3151da0612ec9c3ce8b2c8a64730d625ce5b13cc0c"
  license "Intel"

  depends_on :linux

  def install

    # Seems to have little effect
    components = [
#      "intel.oneapi.lin.mkl.product",
      "intel.oneapi.lin.mkl.devel",
      "intel.oneapi.lin.mkl.runtime",
#      "intel.oneapi.lin.oneapi-common.vars",
#      "intel.oneapi.lin.oneapi-common.licensing",
#      "intel.oneapi.lin.tbb.runtime",
#      "intel.oneapi.lin.dpcpp-cpp-common.runtime",
#      "intel.oneapi.lin.compilers-common.runtime",
      "intel.oneapi.lin.openmp"
    ].join(":")

    args = [
      "-a", "--silent",
      "--eula", "accept",
      "--install-dir", prefix,
      "--components", components
    ]
    system "sh", "l_onemkl_p_2021.1.1.52_offline.sh", *args
  end

  test do
    system "false"
  end
end
