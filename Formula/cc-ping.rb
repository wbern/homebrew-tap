class CcPing < Formula
  desc "Ping Claude Code sessions to trigger quota windows across multiple accounts"
  homepage "https://github.com/wbern/cc-ping"
  license "MIT"
  version "1.21.11"

  livecheck do
    url "https://github.com/wbern/cc-ping/releases/latest"
    regex(/v(\d+(?:\.\d+)+)/i)
  end

  if OS.mac?
    # Build from source on the user's machine. Pre-built binaries
    # downloaded from GitHub Releases get tagged with macOS Sequoia's
    # com.apple.provenance xattr, which Gatekeeper blocks for
    # ad-hoc-signed Mach-O binaries.
    url "https://github.com/wbern/cc-ping/archive/refs/tags/v#{version}.tar.gz"
    sha256 "5f1bdf2b676644366763af1e7f66de922c97bb5620a845931da4a00e93c7386e"
    depends_on "oven-sh/bun/bun" => :build
  elsif OS.linux?
    url "https://github.com/wbern/cc-ping/releases/download/v#{version}/cc-ping-linux-x64"
    sha256 "402a16158cc32706afd60f879a241c1a457a93406e422c65c34772e25710dc17"
  else
    odie "cc-ping: unsupported platform"
  end

  def install
    if OS.mac?
      ENV["BUN_INSTALL_CACHE_DIR"] = buildpath/"bun-cache"
      system "bun", "install", "--no-save"
      system "bun", "build", "--compile", "--minify",
             "--define", "__VERSION__=\"\\\"#{version}\\\"\"",
             "./src/cli.ts", "--outfile", "cc-ping"
      # Re-sign ad-hoc to satisfy Gatekeeper after compile.
      system "codesign", "--remove-signature", "cc-ping"
      system "codesign", "--force", "--sign", "-", "cc-ping"
      bin.install "cc-ping"
    else
      bin.install "cc-ping-linux-x64" => "cc-ping"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cc-ping --version")
  end
end
