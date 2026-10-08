import Foundation
import AppKit
import CoreGraphics
import ImageIO
import UniformTypeIdentifiers

// Reuse existing app assets. No UI, card text, powers, or artwork are synthesized.
// Usage: swift assets/prepare-assets.swift /absolute/path/to/StorylightQuest
let source = URL(fileURLWithPath: CommandLine.arguments[1], isDirectory: true)
let destination = URL(fileURLWithPath: #filePath).deletingLastPathComponent()
let fm = FileManager.default

func load(_ path: String) throws -> CGImage {
    guard let data = CGImageSourceCreateWithURL(source.appendingPathComponent(path) as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(data, 0, nil) else {
        throw NSError(domain: "AssetPreparation", code: 1, userInfo: [NSLocalizedDescriptionKey: path])
    }
    return image
}

func context(_ width: Int, _ height: Int) -> CGContext {
    let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8,
                            bytesPerRow: width * 4, space: CGColorSpace(name: CGColorSpace.sRGB)!,
                            bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)!
    context.interpolationQuality = .high
    return context
}

func export(_ image: CGImage, name: String, width: Int, height: Int, quality: Double = 0.88) throws {
    let output = context(width, height)
    output.draw(image, in: CGRect(x: 0, y: 0, width: width, height: height))
    let url = destination.appendingPathComponent("images/" + name)
    let type = name.hasSuffix(".png") ? UTType.png.identifier : UTType.jpeg.identifier
    guard let file = CGImageDestinationCreateWithURL(url as CFURL, type as CFString, 1, nil) else {
        throw NSError(domain: "AssetPreparation", code: 2)
    }
    CGImageDestinationAddImage(file, output.makeImage()!, [kCGImageDestinationLossyCompressionQuality: quality] as CFDictionary)
    guard CGImageDestinationFinalize(file) else { throw NSError(domain: "AssetPreparation", code: 3) }
    print("\(name): \(width) x \(height)")
}

func tradingCard(_ path: String) throws -> CGImage {
    let original = try load(path)
    precondition(original.width == 900 && original.height == 1500)
    let output = context(900, 1260)
    // Same geometry as CardImageCache.tradingFormat. CGImage crop rectangles
    // use top-origin pixels; CGContext destination rectangles use bottom-origin.
    let top = original.cropping(to: CGRect(x: 0, y: 0, width: 900, height: 676))!
    let bottom = original.cropping(to: CGRect(x: 0, y: 916, width: 900, height: 584))!
    output.draw(top, in: CGRect(x: 0, y: 584, width: 900, height: 676))
    output.draw(bottom, in: CGRect(x: 0, y: 0, width: 900, height: 584))
    output.saveGState()
    output.move(to: CGPoint(x: 240, y: 609))
    output.addLine(to: CGPoint(x: 660, y: 609))
    output.addLine(to: CGPoint(x: 647, y: 584))
    output.addLine(to: CGPoint(x: 253, y: 584))
    output.closePath()
    output.clip()
    output.draw(original, in: CGRect(x: 0, y: 0, width: 900, height: 1500))
    output.restoreGState()
    return output.makeImage()!
}

try fm.createDirectory(at: destination.appendingPathComponent("fonts"), withIntermediateDirectories: true)
try fm.createDirectory(at: destination.appendingPathComponent("images"), withIntermediateDirectories: true)
for file in ["Montserrat-Regular.ttf", "Montserrat-SemiBold.ttf", "Montserrat-Bold.ttf", "Montserrat-ExtraBold.ttf", "Montserrat-OFL-License.txt"] {
    let target = destination.appendingPathComponent("fonts/" + file)
    if fm.fileExists(atPath: target.path) { try fm.removeItem(at: target) }
    try fm.copyItem(at: source.appendingPathComponent("StorylightQuest/Resources/Fonts/" + file), to: target)
}
try export(load("AppStore/screenshots/iphone-6.9/01-journeys.png"), name: "journeys-phone.jpg", width: 660, height: 1434)
try export(load("AppStore/screenshots/iphone-6.9/02-story-quest.png"), name: "story-quest-phone.jpg", width: 660, height: 1434)
try export(load("AppStore/screenshots/ipad-13/05-play-together.png"), name: "together-ipad.jpg", width: 1032, height: 1376)
try export(tradingCard("StorylightQuest/Resources/CardFaces/GodCreatestheWorld[face,1].png"), name: "creation-card.jpg", width: 600, height: 840, quality: 0.92)
try export(tradingCard("StorylightQuest/Resources/CardFaces/JesusCalmstheStorm[face,1].png"), name: "storm-card.jpg", width: 600, height: 840, quality: 0.92)
try export(load("StorylightQuest/Assets.xcassets/CardBack.imageset/cardback.png"), name: "card-back.jpg", width: 600, height: 840, quality: 0.90)
try export(load("StorylightQuest/Assets.xcassets/AppIcon.appiconset/AppIcon.png"), name: "app-icon.png", width: 180, height: 180)
