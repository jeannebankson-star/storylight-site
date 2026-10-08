# Storylight website assets

Prepared from the current Storylight Quest app assets and native App Store screenshots. No new artwork or interface mockups are used.

## Fonts

`fonts/` contains the app's Montserrat Regular, SemiBold, Bold, and ExtraBold TTF files. The included `Montserrat-OFL-License.txt` is their SIL Open Font License.

## Images

| File | Pixels | Source |
| --- | --- | --- |
| `images/journeys-phone.jpg` | 660 × 1434 | `AppStore/screenshots/iphone-6.9/01-journeys.png` |
| `images/story-quest-phone.jpg` | 660 × 1434 | `AppStore/screenshots/iphone-6.9/02-story-quest.png` |
| `images/together-ipad.jpg` | 1032 × 1376 | `AppStore/screenshots/ipad-13/05-play-together.png` |
| `images/creation-card.jpg` | 600 × 840 | `StorylightQuest/Resources/CardFaces/GodCreatestheWorld[face,1].png` |
| `images/storm-card.jpg` | 600 × 840 | `StorylightQuest/Resources/CardFaces/JesusCalmstheStorm[face,1].png` |
| `images/card-back.jpg` | 600 × 840 | `StorylightQuest/Assets.xcassets/CardBack.imageset/cardback.png` |
| `images/app-icon.png` | 180 × 180 | `StorylightQuest/Assets.xcassets/AppIcon.appiconset/AppIcon.png` |

Screenshots are proportionally reduced to half their native width and height, with no crop, compositing, interface changes, or overlays. All exports use sRGB.

The original card faces use a 900 × 1500 template. The website follows the app's `CardImageCache.tradingFormat` composition: retain the upper 676 pixels; move the lower 584 pixels, starting at y=916, upward by 240 pixels; restore the raised story ribbon within the same four-point polygon. The resulting 900 × 1260 composition is reduced to 600 × 840. This preserves the original title, power panels, typography, and ornaments at the standard 5:7 trading-card ratio. The original card back already uses 5:7 and is resized proportionally. These are web display assets, not print masters.

## Regenerate

On macOS with Swift installed, run from the website root:

```sh
swift assets/prepare-assets.swift /absolute/path/to/StorylightQuest
```

The source directory must contain `AppStore/` and the nested `StorylightQuest/` app directory. `prepare-assets.swift` uses CoreGraphics and ImageIO and writes only into this assets directory.
