# Homebrew tap for Split Route

```sh
brew install --cask split-route/tap/splitroute
```

Upgrade with `brew upgrade --cask splitroute`; remove with `brew uninstall --cask splitroute`
(`--zap` also removes the system service and its data).

The cask installs the macOS app from the [split-route/macos](https://github.com/split-route/macos) releases.
The app is not notarized: the cask clears the download quarantine for it, and macOS still asks you to allow
the system service once under System Settings > General > Login Items.

`Casks/splitroute.rb` is written by the release workflow of `split-route/macos`; don't edit it by hand.
