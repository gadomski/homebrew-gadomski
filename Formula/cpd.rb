class Cpd < Formula
  desc "Coherent Point Drift: point set registration"
  homepage "https://gadomski.github.io/cpd"
  url "https://github.com/gadomski/cpd/archive/v0.4.3.tar.gz"
  sha256 "e2043420690e6de4a530745d7514a06719c4c267bd20727ef1ae13fee2bbb017"
  head "https://github.com/gadomski/cpd.git"

  depends_on "cmake" => :build
  depends_on "fgt" => :recommended

  def install
    args = ["-DWITH_DOCS=OFF", "-DWITH_STRICT_WARNINGS=OFF", "-DWITH_TESTS=OFF"]
    if build.with? "fgt"
      args << "-DWITH_FGT=ON"
    else
      args << "-DWITH_FGT=OFF"
    end
    args += std_cmake_args
    system "cmake", ".", *args
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
