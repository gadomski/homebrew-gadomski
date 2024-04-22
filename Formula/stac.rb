class Stac < Formula
  desc "Command line interface for working with STAC data and servers, written in Rust"
  homepage "https://github.com/stac-utils/stac-rs"
  url "https://github.com/stac-utils/stac-rs/archive/refs/tags/stac-cli-v0.0.7.tar.gz"
  sha256 "e10336433d96d6674dbc066652cbc4dfe0d3b040c601e98729e451f6092e1d60"
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
