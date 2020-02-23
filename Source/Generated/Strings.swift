// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
internal enum L10n {
  /// Sorry
  internal static let alertTitleSorry = L10n.tr("Localizable", "alert_title_sorry")
  /// Delivered to: %@
  internal static func deliveredTo(_ p1: String) -> String {
    return L10n.tr("Localizable", "delivered_to", p1)
  }
  /// Sorry, something went wrong!
  internal static let generalError = L10n.tr("Localizable", "general_error")
  /// There is some problem with the data!
  internal static let invalidData = L10n.tr("Localizable", "invalid_data")
  /// Invalid JSON!
  internal static let invalidJson = L10n.tr("Localizable", "invalid_json")
  /// Invalid URL!
  internal static let invalidUrl = L10n.tr("Localizable", "invalid_url")
  /// Maybe the server is not available. Please try again later!
  internal static let loadOrdersErrorMessage = L10n.tr("Localizable", "load_orders_error_message")
  /// OK
  internal static let ok = L10n.tr("Localizable", "ok")
  /// Orders
  internal static let orderListTitle = L10n.tr("Localizable", "order_list_title")
  /// %@ RON
  internal static func orderPriceWithCurrency(_ p1: String) -> String {
    return L10n.tr("Localizable", "order_price_with_currency", p1)
  }
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
