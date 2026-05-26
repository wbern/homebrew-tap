class Obscene < Formula
  desc "Hotspot finder — complexity (via scc) × git churn × temporal coupling"
  homepage "https://github.com/wbern/obscene"
  url "https://registry.npmjs.org/@wbern/obscene/-/obscene-2.12.0.tgz"
  sha256 "753688fc14cef44b7a8b848929949968e846714f794363be7367d4421e0474d1"
  license "MIT"
  version "2.12.0"

  livecheck do
    url "https://github.com/wbern/obscene/releases/latest"
    regex(/v(\d+(?:\.\d+)+)/i)
  end

  depends_on "node"
  depends_on "scc"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/obscene --version")
  end
end
