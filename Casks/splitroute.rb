# Written by the splitroute release workflow (scripts/update-cask.sh).
cask "splitroute" do
  version "0.5.3"
  sha256 "d698ebb9be317dac47569a067ddbcf08ddc8db0f04c3a10b5000d4021836c026"

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
