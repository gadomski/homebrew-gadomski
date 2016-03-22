class Cpd < Formula
  desc "Coherent Point Drift: point set registration"
  homepage "https://gadomski.github.io/cpd"
  url "https://github.com/gadomski/cpd/archive/v0.3.0.tar.gz"
  sha256 "fbdcee8bb200ebab40764a0bd4e03e05113c20d4db23b2260aad4ce968e893ce"
  head "https://github.com/gadomski/cpd.git"

  depends_on "cmake" => :build
  depends_on "fgt"

  def install
    system "cmake", ".", "-DBUILD_SHARED_LIBS=ON", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(Cpd REQUIRED)\n
                                      add_executable(test main.cpp)\n
                                      target_link_libraries(test PRIVATE Cpd::Library-C++)")
    (testpath/"main.cpp").write("#include <cpd/rigid.hpp>\nint main(int argc, char** argv) {}")
    system "cmake", "."
    system "make"
    system "./test"
  end
end
