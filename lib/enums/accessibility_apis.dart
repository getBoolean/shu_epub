/// Indicates that the resource is compatible with the referenced accessibility API.
///
/// Compatibility with an accessibility API indicates that assistive technologies on the platform should be able to access the resource.
/// 
/// The property is not applicable to resources that are not tightly integrated with their user interface.
/// It can describe whether a word processing document that only opens in a specific application will work
/// on a given platform, for example, but is not a useful indicator of whether an HTML document will, as
/// there are numerous user agents a user could use to render it.
/// 
/// Setting the property means that the resource is compatible with the given API(s). It does not
/// necessarily mean that the content will be fully accessible to any given user group.
/// 
/// https://www.w3.org/2021/a11y-discov-vocab/latest/#accessibilityAPI
enum AccessibilityAPI {
  /// Indicates the resource is compatible with the Android Accessibility API.
  androidAccessibility,

  /// Indicates the resource uses ARIA markup to improve interoperability with platform APIs.
  aria,

  /// Indicates the resource is compatible with the Accessibility Toolkit (ATK) API for GNOME.
  atk,

  /// Indicates the resource is compatible with the Assistive Technology Service Provider Interface (AT-SPI) API for GNOME.
  atspi,

  /// Indicates the resource is compatible with the Blackberry Accessibility API.
  blackberryAccessibility,

  /// Indicates the resource is compatible with the iAccessible2 API for Windows.
  iAccessible2,

  /// Indicates the resource is compatible with the iAccessible2 API for Apple iOS devices.
  iOSAccessibility,

  /// Indicates the resource is compatible with the Java Accessibility API (JAAPI).
  javaAccessibility,

  /// Indicates the resource is compatible with the iAccessible2 API for Windows.
  macOSXAccessibility,

  /// Indicates the resource is compatible with the Microsoft Active Accessibility (MSAA) API for Windows.
  msaa,

  /// Indicates the resource is compatible with the User Interface Automation API for Windows.
  uiAutomation,
}



extension AccessibilityAPIExtension on AccessibilityAPI {
  ///  Access the string equivalent of this constant used in EPUBs
  String get value {
    switch (this) {
      case AccessibilityAPI.androidAccessibility:
        return 'AndroidAccessibility';
      case AccessibilityAPI.aria:
        return 'ARIA';
      case AccessibilityAPI.atk:
        return 'ATK';
      case AccessibilityAPI.atspi:
        return 'AT-SPI';
      case AccessibilityAPI.blackberryAccessibility:
        return 'BlackberryAccessibility';
      case AccessibilityAPI.iAccessible2:
        return 'iAccessible2';
      case AccessibilityAPI.iOSAccessibility:
        return 'iOSAccessibility';
      case AccessibilityAPI.javaAccessibility:
        return 'JavaAccessibility';
      case AccessibilityAPI.macOSXAccessibility:
        return 'MacOSXAccessibility';
      case AccessibilityAPI.msaa:
        return 'MSAA';
      case AccessibilityAPI.uiAutomation:
        return 'UIAutomation';
    }
  }
}