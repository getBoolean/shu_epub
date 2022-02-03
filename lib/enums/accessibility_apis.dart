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
class AccessibilityAPIs {
  static List<String> get values => [
        androidAccessibility,
        aria,
        atk,
        atspi,
        blackberryAccessibility,
        iAccessible2,
        iOSAccessibility,
        javaAccessibility,
        macOSXAccessibility,
        msaa,
        uiAutomation,
      ];

  /// Indicates the resource is compatible with the Android Accessibility API.
  static const String androidAccessibility = 'AndroidAccessibility';

  /// Indicates the resource uses ARIA markup to improve interoperability with platform APIs.
  static const String aria = 'ARIA';

  /// Indicates the resource is compatible with the Accessibility Toolkit (ATK) API for GNOME.
  static const String atk = 'ATK';

  /// Indicates the resource is compatible with the Assistive Technology Service Provider Interface (AT-SPI) API for GNOME.
  static const String atspi = 'AT-SPI';

  /// Indicates the resource is compatible with the Blackberry Accessibility API.
  static const String blackberryAccessibility = 'BlackberryAccessibility';

  /// Indicates the resource is compatible with the iAccessible2 API for Windows.
  static const String iAccessible2 = 'iAccessible2';

  /// Indicates the resource is compatible with the iAccessible2 API for Apple iOS devices.
  static const String iOSAccessibility = 'iOSAccessibility';

  /// Indicates the resource is compatible with the Java Accessibility API (JAAPI).
  static const String javaAccessibility = 'JavaAccessibility';

  /// Indicates the resource is compatible with the iAccessible2 API for Windows.
  static const String macOSXAccessibility = 'MacOSXAccessibility';

  /// Indicates the resource is compatible with the Microsoft Active Accessibility (MSAA) API for Windows.
  static const String msaa = 'MSAA';

  /// Indicates the resource is compatible with the User Interface Automation API for Windows.
  static const String uiAutomation = 'UIAutomation';
}