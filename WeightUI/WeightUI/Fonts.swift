// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSFont
  public typealias Font = NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
  public typealias Font = UIFont
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
public enum FontFamily {
  public enum ProximaNova {
    public static let black = FontConvertible(name: "ProximaNova-Black", family: "Proxima Nova", path: "ProximaNovaBlack.otf")
    public static let bold = FontConvertible(name: "ProximaNova-Bold", family: "Proxima Nova", path: "ProximaNovaBold.otf")
    public static let extrabold = FontConvertible(name: "ProximaNova-Extrabld", family: "Proxima Nova", path: "ProximaNovaExtrabold.otf")
    public static let regular = FontConvertible(name: "ProximaNova-Regular", family: "Proxima Nova", path: "ProximaNovaRegular.otf")
    public static let thin = FontConvertible(name: "ProximaNovaT-Thin", family: "Proxima Nova", path: "ProximaNovaThin.otf")
    public static let all: [FontConvertible] = [black, bold, extrabold, regular, thin]
  }
  public static let allCustomFonts: [FontConvertible] = [ProximaNova.all].flatMap { $0 }
  public static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

public struct FontConvertible {
  public let name: String
  public let family: String
  public let path: String

  public func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("No font found for \(name)")
    }
    return font
  }

  public func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    let bundle = Bundle(for: BundleToken.self)
    return bundle.url(forResource: path, withExtension: nil)
  }
}

public extension Font {
  convenience init!(font: FontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}

private final class BundleToken {}
