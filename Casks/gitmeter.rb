cask "gitmeter" do
  version "0.1.6"
  sha256 "d644dbf8873d1388d5279c7b576777815194ce10570ea4a627b3c04e7e6d6207"

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

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/GitMeter.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.marcosfabriciio.GitMeter",
    "~/Library/Preferences/com.marcosfabriciio.GitMeter.plist",
  ]

  caveats <<~EOS
    App assinado ad-hoc (sem notarização da Apple). O cask remove o atributo
    de quarentena automaticamente após a instalação, então o app abre normalmente.

    Para instalar:
      brew install --cask MarcosFabriciio/tap/gitmeter

    Se o Gatekeeper ainda bloquear após a instalação, execute:
      xattr -dr com.apple.quarantine /Applications/GitMeter.app
    Ou acesse Ajustes do Sistema → Privacidade e Segurança → "Abrir mesmo assim".

    Por padrão usa o token do gh CLI (brew install gh && gh auth login),
    ou configure um PAT (escopo repo) nos Ajustes do app.
  EOS
end
