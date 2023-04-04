class Stac < Formula
  desc "Command line interface for working with STAC data and servers, written in Rust"
  homepage "https://gtihub.com/gadomski/stac-rs"
  url "https://github.com/gadomski/stac-rs/archive/refs/tags/stac-cli-v0.0.3.tar.gz"
  sha256 "c1561c2c33fd967287e87e1e27240b2342541bc94ba275bd41d136c10dfb0ca0"
  license "MIT OR Apache-2.0"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "stac-cli"
  end

  test do
    system "#{bin}/stac", "validate", "https://raw.githubusercontent.com/radiantearth/stac-spec/fd8fb4e3cf0b6c4a0fe74822accbc1725a92f92a/examples/simple-item.json"
  end
end
