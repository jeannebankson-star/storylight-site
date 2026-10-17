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
| `images/creation-card-radiant.jpg` | 600 × 1000 | `StorylightQuest/Resources/CardFaces/GodCreatestheWorld[face,1].png` |
| `images/storm-card-radiant.jpg` | 600 × 1000 | `StorylightQuest/Resources/CardFaces/JesusCalmstheStorm[face,1].png` |
| `images/card-back-little-lights.png` | 600 × 1000 | `StorylightQuest/Resources/CardBacks/littleLights.png` |
| `images/card-back-explorers.png` | 600 × 1000 | `StorylightQuest/Resources/CardBacks/explorers.png` |
| `images/app-icon.png` | 180 × 180 | `StorylightQuest/Assets.xcassets/AppIcon.appiconset/AppIcon.png` |

Screenshots are proportionally reduced to half their native width and height, with no crop, compositing, interface changes, or overlays. All exports use sRGB.

The cards are the Radiant Storybook fronts and the Little Lights and Explorers editions of the Book of Light backs, from StorylightQuest commit `54848a0` on `launch-readiness`. Fronts and backs are complete 900 × 1500 cards (3:5), so each is reduced whole to 600 × 1000 with no crop or recomposition. Fronts are JPEG; the flat-color backs are PNG, which is smaller and sharper for them. These are web display assets, not print masters.

## Regenerate

On macOS with Swift installed, run from the website root:

```sh
swift assets/prepare-assets.swift /absolute/path/to/StorylightQuest
```

The source directory must contain `AppStore/` and the nested `StorylightQuest/` app directory, from a checkout that includes the Radiant Storybook cards and `Resources/CardBacks/`. `prepare-assets.swift` uses CoreGraphics and ImageIO and writes only into this assets directory.

If the source artwork changes, change the export names in `prepare-assets.swift` and the matching references in `index.html` (as with the `-radiant` card fronts) so browsers don't keep showing cached copies of the old images.
