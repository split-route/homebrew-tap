# Written by the splitroute release workflow (scripts/update-cask.sh).
cask "splitroute" do
  version "0.6.0"
  sha256 "f4c0a8694a4ed8798b61f8f1a6e1fe9ddf353cce560199b6fa3124f23c754a90"

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
