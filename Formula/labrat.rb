class Labrat < Formula
  desc "A fast, lightweight GitLab simulator for testing anything that talks to GitLab"
  homepage "https://github.com/mabn/labrat"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mabn/labrat/releases/download/v0.1.0/labrat-aarch64-apple-darwin.tar.xz"
      sha256 "7be3af7e625e8a8cad1769b3f4c607e743ebc1784d76a3a6602963c42085ca65"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mabn/labrat/releases/download/v0.1.0/labrat-x86_64-apple-darwin.tar.xz"
      sha256 "e3183e2d2fac5d492d8fb8c613f411021f03ed31fb1ceae32f96634b04f86211"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mabn/labrat/releases/download/v0.1.0/labrat-aarch64-unknown-linux-musl.tar.xz"
      sha256 "1db8ca38f3b5b8e0bb64eac65e1a6bab8691f6cc5a80c682ee6a6d619b3d6bdd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mabn/labrat/releases/download/v0.1.0/labrat-x86_64-unknown-linux-musl.tar.xz"
      sha256 "11ab5d923f5eb2f716b1bc1271999e69e705e139d2ce41d6528d5f3da1445bf2"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "labrat"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "labrat"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "labrat"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "labrat"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
