class Labrat < Formula
  desc "A fast, lightweight GitLab simulator for testing anything that talks to GitLab"
  homepage "https://github.com/mabn/labrat"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mabn/labrat/releases/download/v0.2.0/labrat-aarch64-apple-darwin.tar.xz"
      sha256 "f33167359f8bb1c25d72139c09a910a7c58c06a3848eff3bde28e7690a560b73"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mabn/labrat/releases/download/v0.2.0/labrat-x86_64-apple-darwin.tar.xz"
      sha256 "06f7f1bf1b2b504278eb2755d1a7d81a32a984b15bc3c4c2ac9dc7206112517c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mabn/labrat/releases/download/v0.2.0/labrat-aarch64-unknown-linux-musl.tar.xz"
      sha256 "83bd4ed8f2b0865db6a3778b2cef9d1b6bb624d3b7159043f392532142f3343c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mabn/labrat/releases/download/v0.2.0/labrat-x86_64-unknown-linux-musl.tar.xz"
      sha256 "7ff30deb60cd0a1bbb8fea99fcf216ed27e855ae9d210717f807aac9385aa0d0"
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
