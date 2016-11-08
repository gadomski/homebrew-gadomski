class Cpd < Formula
  desc "Coherent Point Drift: point set registration"
  homepage "https://gadomski.github.io/cpd"
  url "https://github.com/gadomski/cpd/archive/v0.4.1.tar.gz"
  sha256 "5be3c16261cdd693b7f177f27a6ebdc362018f56f7344c73902341945c3daf9f"
  head "https://github.com/gadomski/cpd.git"

  depends_on "cmake" => :build
  depends_on "fgt"

  def install
    system "cmake", ".", "-DBUILD_SHARED_LIBS=ON", "-DWITH_DOCS=OFF", "-DWITH_STRICT_WARNINGS=OFF", "-DWITH_TESTS=OFF", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(Cpd REQUIRED)\n
                                      add_executable(test main.cpp)\n
                                      target_link_libraries(test PRIVATE Cpd::Library-C++)")
    (testpath/"main.cpp").write("#include <cpd/version.hpp>\n#include <cstdio>\nint main(int argc, char** argv) { printf(\"%s\\n\", cpd::version()); return 0; }")
    system "cmake", "."
    system "make"
    system "./test"
  end
end
