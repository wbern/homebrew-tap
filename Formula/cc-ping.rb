class CcPing < Formula
  desc "Ping Claude Code sessions to trigger quota windows across multiple accounts"
  homepage "https://github.com/wbern/cc-ping"
  license "MIT"
  version "1.26.0"

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
    sha256 "c826f459b71aab6fe13c7fc3d82463e2443dd0580e8e1e8dd7049adc493d6500"
    depends_on "oven-sh/bun/bun" => :build
  elsif OS.linux?
    url "https://github.com/wbern/cc-ping/releases/download/v#{version}/cc-ping-linux-x64"
    sha256 "c257cba3680bb812ac1aa5f10cd7d365cb232a9663d2c8f0794581b9a9e9ff0c"
  else
    odie "cc-ping: unsupported platform"
  end

  def install
    if OS.mac?
      ENV["BUN_INSTALL_CACHE_DIR"] = buildpath/"bun-cache"
      system "bun", "install", "--no-save"
      system "bun", "build", "--compile", "--minify",
             "--define", "__VERSION__=\"#{version}\"",
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
