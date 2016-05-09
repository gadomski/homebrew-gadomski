class Cpd < Formula
  desc "Coherent Point Drift: point set registration"
  homepage "https://gadomski.github.io/cpd"
  url "https://github.com/gadomski/cpd/archive/v0.3.3.tar.gz"
  sha256 "2507851aa8096265e842551a90c7658d19736ec6fdf2fe496491c93b760253ba"
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
