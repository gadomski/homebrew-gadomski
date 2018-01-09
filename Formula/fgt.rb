class Fgt < Formula
  desc "C++ library for fast Gauss transforms"
  homepage "https://gadomski.github.io/fgt"
  url "https://github.com/gadomski/fgt/archive/v0.4.6.tar.gz"
  sha256 "fa41073759dc4282c3fd5fa362f42461d7d95fa7f5f199b114384cb93dbc7a81"
  head "https://github.com/gadomski/fgt.git"

  depends_on "cmake" => :build
  depends_on "eigen"

  def install
    system "cmake", ".", "-DWITH_BENCH=OFF", "-DWITH_OPENMP=OFF", "-DWITH_TESTS=OFF", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(Fgt REQUIRED)\n
                                      add_executable(test main.cpp)\n
                                      target_link_libraries(test PRIVATE Fgt::Library-C++)")
    (testpath/"main.cpp").write("#include <fgt.hpp>\nint main(int argc, char** argv) { printf(\"fgt version: %s\\n\", fgt::version()); }")
    system "cmake", "."
    system "make"
    system "./test"
  end
end
