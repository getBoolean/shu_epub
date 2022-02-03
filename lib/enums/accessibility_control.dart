/// Identifies one or more input methods that allow access to all of the application functionality.
///
/// The `accessibilityControl` property is used to describe the ability of users to interact with the
/// user interface controls that applications provide.
///
/// The property is not applicable to resources that are not tightly integrated with their user
/// interface. It can describe whether users can control a word processing document that only
/// opens in a specific application, for example, but is not a useful indicator of whether users
/// can control an HTML document, as there are numerous user agent and assistive technology
/// pairings a user could use to access it.
///
/// Setting the property means that the specified control method(s) are compatible with the resource.
enum AccessibilityControl {
  /// Users can fully control the resource through keyboard input.
  fullKeyboardControl,

  /// Users can fully control the resource through mouse input.
  fullMouseControl,

  /// Users can fully control the resource through switch input.
  fullSwitchControl,

  /// Users can fully control the resource through touch input.
  fullTouchControl,

  /// Users can fully control the resource through video input.
  fullVideoControl,

  /// Users can fully control the resource through voice input.
  fullVoiceControl,
}
