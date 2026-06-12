cask "gitmeter" do
  version "0.1.2"
  sha256 "e739ce4537c8b4f2db7ac2e463f0cd35a08734fe3dba664b79ebc535730d518c"

  url "https://github.com/MarcosFabriciio/git-meter/releases/download/v#{version}/GitMeter-#{version}.zip"
  name "GitMeter"
  desc "App de menu bar para acompanhar pull requests do GitHub"
  homepage "https://github.com/MarcosFabriciio/git-meter"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "GitMeter.app"

  zap trash: [
    "~/Library/Application Support/com.marcosfabriciio.GitMeter",
    "~/Library/Preferences/com.marcosfabriciio.GitMeter.plist",
  ]

  caveats <<~EOS
    App assinado ad-hoc (sem notarização da Apple). Instale com:
      brew install --cask --no-quarantine MarcosFabriciio/tap/gitmeter
    Se já instalou e o macOS bloquear: xattr -dr com.apple.quarantine /Applications/GitMeter.app
    Por padrão usa o token do gh CLI (brew install gh && gh auth login),
    ou configure um PAT (escopo repo) nos Ajustes do app.
  EOS
end
