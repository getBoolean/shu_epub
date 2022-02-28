part of shu_epub.enums;

/// There are three widely-recognized hazards that can affect readers of digital content:
///
/// * flashing — if a resource flashes more than three times a second, it can cause seizures (e.g., videos and animations). See also [WCAG 2.0 Guideline 2.3](http://www.w3.org/TR/WCAG20/#seizure).
///
/// * motion simulation — if a resource simulates motion, it can cause a user to become nauseated (e.g., a video game drawn on the [HTML canvas element](https://www.w3.org/TR/html5/scripting-1.html#the-canvas-element)).
///
/// * sound — certain sound patterns, such as ringing and buzzing, can cause seizures.
///
/// Authors have to report whether or not their EPUB Publications contain resources
/// that present any of these hazards to users, as they can have real physical effects.
///
/// Unlike other accessibility properties, the presence of hazards can be expressed both positively and negatively.
/// This design decision was made because users most often search for content that is free from hazards that affect
/// them, but also want to know what dangers are present in any publications they discover.
///
/// The following example shows the metadata entries for an EPUB 3 Publication that has a flashing hazard but no motion simulation or sound hazards.
///
/// ```
/// <meta property="schema:accessibilityHazard">flashing</meta>
/// <meta property="schema:accessibilityHazard">noMotionSimulationHazard</meta>
/// <meta property="schema:accessibilityHazard">noSoundHazard</meta>
/// ```
///
/// Do not skip reporting hazards just because an EPUB Publication does not contain any content that could present risks.
/// Users cannot infer a meaning when no metadata is present. The value [AccessibilityHazard.none] can be used in such
/// cases instead of repeating each non-hazard.
///
/// If hazards cannot be definitively determined, report the value [AccessibilityHazard.unknown].
///
/// https://www.w3.org/2021/a11y-discov-vocab/latest/#accessibilityHazard
enum AccessibilityHazard {
  /// Indicates that the resource presents a flashing hazard for photosensitive persons.
  ///
  /// This value should be set when the content meets the hazard thresholds described in [Success Criterion 2.3.1 Three Flashes or Below Threshold](https://www.w3.org/TR/WCAG21/#three-flashes-or-below-threshold).
  flashing,

  /// Indicates that the resource does not present a flashing hazard.
  ///
  /// This value should be set when the content conforms to [Success Criterion 2.3.1 Three Flashes or Below Threshold](https://www.w3.org/TR/WCAG21/#three-flashes-or-below-threshold).
  noFlashingHazard,

  /// Indicates that the resource contains instances of motion simulation that may affect some individuals.
  ///
  /// Some examples of motion simulation include video games with a first-person perspective and
  /// CSS-controlled backgrounds that move when a user scrolls a page.
  motionSimulation,

  /// Indicates that the resource does not contain instances of motion simulation.
  noMotionSimulationHazard,

  /// Indicates that the resource contains auditory sounds that may affect some individuals.
  ///
  /// NOTE: The application of this value is currently under discussion as its application is underspecified.
  sound,

  /// Indicates that the resource does not contain auditory hazards.
  ///
  /// NOTE: The application of this value is currently under discussion as its application is underspecified.
  noSoundHazard,

  /// Indicates that the author is not able to determine if the resource presents any hazards.
  unknown,

  /// Indicates that the resource does not contain any hazards.
  none,
}

extension AccessibilityHazardExtension on AccessibilityHazard {
  /// The string equivalent of this constant property used in EPUBs
  String get value {
    switch (this) {
      case AccessibilityHazard.flashing:
        return 'flashing';
      case AccessibilityHazard.noFlashingHazard:
        return 'noFlashingHazard';
      case AccessibilityHazard.motionSimulation:
        return 'motionSimulation';
      case AccessibilityHazard.noMotionSimulationHazard:
        return 'noMotionSimulationHazard';
      case AccessibilityHazard.sound:
        return 'sound';
      case AccessibilityHazard.noSoundHazard:
        return 'noSoundHazard';
      case AccessibilityHazard.unknown:
        return 'unknown';
      case AccessibilityHazard.none:
        return 'none';
    }
  }
}
