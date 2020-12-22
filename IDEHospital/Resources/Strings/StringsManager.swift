// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Book Now
  internal static let bookNow = L10n.tr("Localizable", "bookNow")
  /// Choose City first
  internal static let chooseCityFirst = L10n.tr("Localizable", "chooseCityFirst")
  /// Choose Services
  internal static let chooseServices = L10n.tr("Localizable", "chooseServices")
  /// Choose City
  internal static let city = L10n.tr("Localizable", "city")
  /// Choose Company
  internal static let company = L10n.tr("Localizable", "company")
  /// Please enter all textfields above
  internal static let dataRequirements = L10n.tr("Localizable", "dataRequirements")
  /// Dismiss
  internal static let dismiss = L10n.tr("Localizable", "dismiss")
  /// Doctor Name
  internal static let doctorName = L10n.tr("Localizable", "doctorName")
  /// Done
  internal static let done = L10n.tr("Localizable", "done")
  /// Email should be : example@mail.com
  internal static let emailRequiremtnts = L10n.tr("Localizable", "emailRequiremtnts")
  /// en
  internal static let en = L10n.tr("Localizable", "en")
  /// Enter Details
  internal static let enterDetails = L10n.tr("Localizable", "enterDetails")
  /// Favorite
  internal static let favorite = L10n.tr("Localizable", "favorite")
  /// Fees
  internal static let fees = L10n.tr("Localizable", "fees")
  /// Find a doctor
  internal static let findDoctor = L10n.tr("Localizable", "findDoctor")
  /// IDEA EG HOSPITAL
  internal static let firstTitle = L10n.tr("Localizable", "firstTitle")
  /// HOME NURSE
  internal static let homeNurse = L10n.tr("Localizable", "homeNurse")
  /// If you would like further information about how we can help you and your health it would be great to hear from you
  internal static let info = L10n.tr("Localizable", "info")
  /// Invalid Email
  internal static let invalidEmail = L10n.tr("Localizable", "invalidEmail")
  /// Invalid Name
  internal static let invalidName = L10n.tr("Localizable", "invalidName")
  /// Invalid Phone Number
  internal static let invalidPhoneNumber = L10n.tr("Localizable", "invalidPhoneNumber")
  /// LE
  internal static let le = L10n.tr("Localizable", "LE")
  /// Minutes
  internal static let minutes = L10n.tr("Localizable", "minutes")
  /// Missed Data
  internal static let missedData = L10n.tr("Localizable", "missedData")
  /// Mobile Number
  internal static let mobileNumber = L10n.tr("Localizable", "mobileNumber")
  /// MY APPOINTMENTS
  internal static let myAppointments = L10n.tr("Localizable", "myAppointments")
  /// MY FAVORITES
  internal static let myFavorites = L10n.tr("Localizable", "myFavorites")
  /// Name should contain letters only, at least 3 characters and and at most 18 characters
  internal static let nameRequirements = L10n.tr("Localizable", "nameRequirements")
  /// No Doctors Found
  internal static let noDoctorsFound = L10n.tr("Localizable", "noDoctorsFound")
  /// Please enter valid phone number ex : 010xxxxxxxx
  internal static let phoneRequirements = L10n.tr("Localizable", "phoneRequirements")
  /// Choose Region
  internal static let region = L10n.tr("Localizable", "region")
  /// Reviews
  internal static let reviews = L10n.tr("Localizable", "reviews")
  /// Schedule
  internal static let schedule = L10n.tr("Localizable", "schedule")
  /// search
  internal static let search = L10n.tr("Localizable", "search")
  /// SEARCH RESULTS
  internal static let searchResults = L10n.tr("Localizable", "searchResults")
  /// IDEA EG HOSPITAL THE BEST CHOICE
  internal static let secondTitle = L10n.tr("Localizable", "secondTitle")
  /// Send Request
  internal static let sendRequest = L10n.tr("Localizable", "sendRequest")
  /// Service Search
  internal static let serviceSearch = L10n.tr("Localizable", "serviceSearch")
  /// Sorry
  internal static let sorry = L10n.tr("Localizable", "sorry")
  /// Sort By
  internal static let sortBy = L10n.tr("Localizable", "sortBy")
  /// Choose Specialist
  internal static let specialist = L10n.tr("Localizable", "specialist")
  /// Waiting Time
  internal static let waitingTime = L10n.tr("Localizable", "waitingTime")
  /// Your Email
  internal static let yourEmail = L10n.tr("Localizable", "yourEmail")
  /// Your Name
  internal static let yourName = L10n.tr("Localizable", "yourName")
  /// Your request was sent
  internal static let yourRequestWasSent = L10n.tr("Localizable", "yourRequestWasSent")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
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
