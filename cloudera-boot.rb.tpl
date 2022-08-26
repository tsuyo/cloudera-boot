class ClouderaBoot < Formula
  desc "cloudera boot"
  homepage "https://github.com/tsuyo/cloudera-boot"
  url "https://github.com/tsuyo/homebrew-tap/raw/master/archive/${ARTIFACT}"
  sha256 "${SHA256}"
  version "${VERSION}"
  license "MIT"

  def install
    bin.install "cboot"
    bin.install "cloudera-director"
  end
end
