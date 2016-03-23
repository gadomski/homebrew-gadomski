class Fgt < Formula
  desc "C++ library for fast Gauss transforms"
  homepage "https://gadomski.github.io/fgt"
  url "https://github.com/gadomski/fgt/archive/v0.4.4.tar.gz"
  sha256 "e3f4f387281ecc489bca5fe84d63ba020f9f4da0e90151fad364e4735ce8f8ba"
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
