// The macOS app icon, from the same cube the phones use.
//
// macOS does not mask an icon the way iOS and Android do: the file *is* the
// shape on the Dock. Since Big Sur that shape is a rounded square of 824 pt on
// a 1024 canvas, with the rest left transparent for the system's shadow to
// fall into. `cube.png` is full-bleed (iOS rounds it itself), so used as-is it
// sits in the Dock as a hard black square, larger than every icon beside it.
//
// So: the brand background in Apple's grid, and the transparent cube on top.
//
//   swift tool/build_macos_icon.swift
import AppKit

let root = URL(fileURLWithPath: #filePath).deletingLastPathComponent().deletingLastPathComponent()
let cubeURL = root.appendingPathComponent("assets/logo/cube_transparent.png")
let outDir = root.appendingPathComponent("macos/Runner/Assets.xcassets/AppIcon.appiconset")

guard let cube = NSImage(contentsOf: cubeURL),
      let cubeCG = cube.cgImage(forProposedRect: nil, context: nil, hints: nil)
else { fatalError("cannot read \(cubeURL.path)") }

func render(_ px: Int) -> Data {
    let s = CGFloat(px) / 1024
    let ctx = CGContext(
        data: nil, width: px, height: px, bitsPerComponent: 8, bytesPerRow: 0,
        space: CGColorSpace(name: CGColorSpace.sRGB)!,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    )!
    ctx.interpolationQuality = .high

    // Apple's macOS 11 grid: 824 square, 100 inset, ~185 corner radius.
    let tile = CGRect(x: 100 * s, y: 100 * s, width: 824 * s, height: 824 * s)
    let shape = CGPath(roundedRect: tile, cornerWidth: 185 * s, cornerHeight: 185 * s, transform: nil)

    ctx.saveGState()
    ctx.setShadow(offset: CGSize(width: 0, height: -10 * s), blur: 20 * s,
                  color: CGColor(gray: 0, alpha: 0.35))
    ctx.addPath(shape)
    ctx.setFillColor(CGColor(srgbRed: 0x06 / 255, green: 0x14 / 255, blue: 0x0D / 255, alpha: 1))
    ctx.fillPath()
    ctx.restoreGState()

    // At the tile's full size the cube nearly touches the rounded corners and
    // reads larger than its Dock neighbours; 86% leaves it the margin they have.
    ctx.saveGState()
    ctx.addPath(shape)
    ctx.clip()
    ctx.draw(cubeCG, in: tile.insetBy(dx: tile.width * 0.07, dy: tile.height * 0.07))
    ctx.restoreGState()

    let rep = NSBitmapImageRep(cgImage: ctx.makeImage()!)
    return rep.representation(using: .png, properties: [:])!
}

for px in [16, 32, 64, 128, 256, 512, 1024] {
    let url = outDir.appendingPathComponent("app_icon_\(px).png")
    try! render(px).write(to: url)
    print("wrote \(url.lastPathComponent)")
}
