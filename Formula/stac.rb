class Stac < Formula
  desc "Command line interface for working with STAC data and servers, written in Rust"
  homepage "https://github.com/stac-utils/stac-rs"
  url "https://github.com/stac-utils/stac-rs/archive/refs/tags/stac-cli-v0.0.8.tar.gz"
  sha256 "2d4edf43ac74c5b0f2cee3c2f5f8ccf0029a84f2efecdaee13d07ecd902f5a3e"
  license "MIT OR Apache-2.0"

  depends_on "rust" => :build
  depends_on "gdal"

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "stac-cli"
  end

  test do
    system "#{bin}/stac", "validate", "https://raw.githubusercontent.com/radiantearth/stac-spec/fd8fb4e3cf0b6c4a0fe74822accbc1725a92f92a/examples/simple-item.json"
  end
end
