class Obscene < Formula
  desc "Hotspot finder — complexity (via scc) × git churn × temporal coupling"
  homepage "https://github.com/wbern/obscene"
  url "https://registry.npmjs.org/@wbern/obscene/-/obscene-2.14.0.tgz"
  sha256 "5196a30cbd8dc62d6f7e1a7c7a702c35925f57d83ea6a4206871f44238c42d97"
  license "MIT"
  version "2.14.0"

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
