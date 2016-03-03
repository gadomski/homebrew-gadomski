class Fgt < Formula
  desc "C++ library for fast Gauss transforms"
  homepage "https://gadomski.github.io/fgt"
  url "https://github.com/gadomski/fgt/archive/v0.4.2.tar.gz"
  sha256 "11b1c0b464ec6eeb61723e4057e278c10ce976d7a1e3c1add4e20ea19d402537"
  head "https://github.com/gadomski/fgt.git"

  depends_on "cmake" => :build
  depends_on "eigen"

  def install
    system "cmake", ".", "-DBUILD_SHARED_LIBS=ON", "-DWITH_BENCH=OFF", *std_cmake_args
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
