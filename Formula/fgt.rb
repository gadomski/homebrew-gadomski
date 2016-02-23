class Fgt < Formula
  desc "C++ library for fast Gauss transforms"
  homepage "https://gadomski.github.io/fgt"
  url "https://github.com/gadomski/fgt/archive/v0.3.1.tar.gz"
  sha256 "d10170f3e1d0a59f025d5f9fc3ad772abb2833357167fa866e2d5015c6e9d4e8"
  head "https://github.com/gadomski/fgt.git"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", "-DBUILD_SHARED_LIBS=ON", "-DWITH_BENCH=OFF", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(Fgt REQUIRED)\n
                                      add_executable(test main.cpp)\n
                                      target_link_libraries(test PRIVATE Fgt::Library-C++)")
    (testpath/"main.cpp").write("#include <fgt.hpp>\nint main(int argc, char** argv) { printf(\"fgt version: %s\\n\"); }")
    system "cmake", "."
    system "make"
    system "./test"
  end
end
