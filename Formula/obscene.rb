class Obscene < Formula
  desc "Hotspot finder — complexity (via scc) × git churn × temporal coupling"
  homepage "https://github.com/wbern/obscene"
  url "https://registry.npmjs.org/@wbern/obscene/-/obscene-2.13.0.tgz"
  sha256 "79a2f93287596d7e6711a30893e4b625395ead965fa77680eb91b17d7c81e54a"
  license "MIT"
  version "2.13.0"

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
