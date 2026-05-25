class Obscene < Formula
  desc "Hotspot finder — complexity (via scc) × git churn × temporal coupling"
  homepage "https://github.com/wbern/obscene"
  url "https://registry.npmjs.org/@wbern/obscene/-/obscene-2.11.0.tgz"
  sha256 "9acbe8d3658938a5b300ba176e238e8628fb73c9f73f16b4efb9f259e7eb4c18"
  license "MIT"
  version "2.11.0"

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
