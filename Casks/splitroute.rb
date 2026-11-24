# Written by the splitroute release workflow (scripts/update-cask.sh).
cask "splitroute" do
  version "0.3.1"
  sha256 "b6be506dd8de95a66754ff74663cc3ce7a8be88733fb5e8f9b4ae116dd0a48ab"

  url "https://github.com/split-route/macos/releases/download/v#{version}/Splitroute_#{version}_macos.dmg"
  name "splitroute"
  desc "VPN with routing lists: send traffic direct, block it, or through a chosen server"
  homepage "https://github.com/split-route/macos"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "Splitroute.app"
  # Not notarized: without this macOS refuses to open it.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Splitroute.app"]
  end

  uninstall quit: "io.github.aliraghebi.splitroute.app"

  # Not in `uninstall`: that also runs on every upgrade and would remove the service.
  zap launchctl: "io.github.aliraghebi.splitroute",
      delete:    [
        "/Library/LaunchDaemons/io.github.aliraghebi.splitroute.plist",
        "/var/db/splitroute",
      ]
end
