// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// am
  internal static let am = L10n.tr("Localizable", "am")
  /// Choose City first
  internal static let chooseCityFirst = L10n.tr("Localizable", "chooseCityFirst")
  /// Choose Services
  internal static let chooseServices = L10n.tr("Localizable", "chooseServices")
  /// Choose City
  internal static let city = L10n.tr("Localizable", "city")
  /// Choose Company
  internal static let company = L10n.tr("Localizable", "company")
  /// EEEE,d MMMM yyyy
  internal static let dateFormat = L10n.tr("Localizable", "dateFormat")
  /// Are You Sure Want to Delete this Appointment?
  internal static let deleteAppointment = L10n.tr("Localizable", "deleteAppointment")
  /// Are You Sure Want to Delete this Favorite?
  internal static let deleteFavorite = L10n.tr("Localizable", "deleteFavorite")
  /// Dismiss
  internal static let dismiss = L10n.tr("Localizable", "dismiss")
  /// Doctor Name
  internal static let doctorName = L10n.tr("Localizable", "doctorName")
  /// en
  internal static let en = L10n.tr("Localizable", "en")
  /// Examination Fees : 
  internal static let examinationFee = L10n.tr("Localizable", "examinationFee")
  /// Favorite
  internal static let favorite = L10n.tr("Localizable", "favorite")
  /// this feature will be available soon
  internal static let feature = L10n.tr("Localizable", "feature")
  /// Find a doctor
  internal static let findDoctor = L10n.tr("Localizable", "findDoctor")
  /// IDEA EG HOSPITAL
  internal static let firstTitle = L10n.tr("Localizable", "firstTitle")
  /// LE
  internal static let le = L10n.tr("Localizable", "le")
  /// minutes
  internal static let mins = L10n.tr("Localizable", "mins")
  /// MY APPOINTMENTS
  internal static let myAppointments = L10n.tr("Localizable", "myAppointments")
  /// MY FAVORITES
  internal static let myFavorites = L10n.tr("Localizable", "myFavorites")
  /// No
  internal static let no = L10n.tr("Localizable", "no")
  /// No Appointments Found!
  internal static let noAppointmentFound = L10n.tr("Localizable", "noAppointmentFound")
  /// No Favorites Found!
  internal static let noFavoriteFound = L10n.tr("Localizable", "noFavoriteFound")
  /// pm
  internal static let pm = L10n.tr("Localizable", "pm")
  /// Choose Region
  internal static let region = L10n.tr("Localizable", "region")
  /// Review
  internal static let review = L10n.tr("Localizable", "review")
  /// Schedule
  internal static let schedule = L10n.tr("Localizable", "schedule")
  /// search
  internal static let search = L10n.tr("Localizable", "search")
  /// IDEA EG HOSPITAL THE BEST CHOICE
  internal static let secondTitle = L10n.tr("Localizable", "secondTitle")
  /// Service Search
  internal static let serviceSearch = L10n.tr("Localizable", "serviceSearch")
  /// Sorry
  internal static let sorry = L10n.tr("Localizable", "sorry")
  /// Choose Specialist
  internal static let specialist = L10n.tr("Localizable", "specialist")
  /// hh:mm a
  internal static let timeFormat = L10n.tr("Localizable", "timeFormat")
  /// View Profile
  internal static let viewProfile = L10n.tr("Localizable", "viewProfile")
  /// Waiting Time : 
  internal static let waitingTime = L10n.tr("Localizable", "waitingTime")
  /// Yes
  internal static let yes = L10n.tr("Localizable", "yes")
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
