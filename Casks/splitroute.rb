# Written by the splitroute release workflow (scripts/update-cask.sh).
cask "splitroute" do
  version "0.4.0"
  sha256 "001376fb3d6b0bec2085ed7090cd8876bae913b7a1d868aea3148a9f1e10ee6e"

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
