// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let cancelBtn = ImageAsset(name: "cancelBtn")
  internal static let cellPin = ImageAsset(name: "cellPin")
  internal static let feeImg = ImageAsset(name: "feeImg")
  internal static let specialtyImg = ImageAsset(name: "specialtyImg")
  internal static let starEmpty = ImageAsset(name: "starEmpty")
  internal static let starFilled = ImageAsset(name: "starFilled")
  internal static let waitingTimeImg = ImageAsset(name: "waitingTimeImg")
  internal static let email = ImageAsset(name: "email")
  internal static let name = ImageAsset(name: "name")
  internal static let phone = ImageAsset(name: "phone")
  internal static let clock = ImageAsset(name: "clock")
  internal static let emptyHeart = ImageAsset(name: "emptyHeart")
  internal static let emptyStar = ImageAsset(name: "emptyStar")
  internal static let filledHeart = ImageAsset(name: "filledHeart")
  internal static let filledStar = ImageAsset(name: "filledStar")
  internal static let money = ImageAsset(name: "money")
  internal static let whiteArrow = ImageAsset(name: "whiteArrow")
  internal static let arrow = ImageAsset(name: "arrow")
  internal static let back = ImageAsset(name: "back")
  internal static let doctor = ImageAsset(name: "doctor")
  internal static let life = ImageAsset(name: "life")
  internal static let medicalHeart = ImageAsset(name: "medicalHeart")
  internal static let pin = ImageAsset(name: "pin")
  internal static let settings = ImageAsset(name: "settings")
  internal static let about = ImageAsset(name: "about")
  internal static let calendar3 = ImageAsset(name: "calendar3")
  internal static let contact = ImageAsset(name: "contact")
  internal static let editProfile = ImageAsset(name: "editProfile")
  internal static let heart3 = ImageAsset(name: "heart3")
  internal static let login = ImageAsset(name: "login")
  internal static let logout = ImageAsset(name: "logout")
  internal static let share = ImageAsset(name: "share")
  internal static let terms = ImageAsset(name: "terms")
  internal static let calendar = ImageAsset(name: "calendar")
  internal static let heart = ImageAsset(name: "heart")
  internal static let search = ImageAsset(name: "search")
  internal static let back2 = ImageAsset(name: "back2")
  internal static let background = ImageAsset(name: "background")
  internal static let component22 = ImageAsset(name: "component22")
  internal static let group1 = ImageAsset(name: "group1")
  internal static let password = ImageAsset(name: "password")
  internal static let path1570 = ImageAsset(name: "path1570")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
