import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:equatable/equatable.dart';

import '../../enums/enums.dart';
import '../../readers/package_reader.dart';

class PackageFile extends Equatable {
  PackageFile({
    this.accessModes,
    this.accessibilityFeatures,
    this.accessibilityHazards,
    this.accessibilitySummary,
    this.accessibilitySummaryByLanguage,
    this.accessModeSufficientList,
    this.accessibilityAPIs,
    this.accessibilityControls,
  });

  /// A human sensory perceptual system or cognitive faculty necessary to process or perceive the content (e.g., textual, visual, auditory, tactile).
  final List<AccessMode>? accessModes;

  /// Features and adaptations that contribute to the overall accessibility of the content (e.g., alternative text, extended descriptions, captions).
  final List<AccessibilityFeature>? accessibilityFeatures;

  /// Any potential hazards that the content presents (e.g., flashing, motion simulation, sound).
  final List<AccessibilityHazard>? accessibilityHazards;

  /// A human-readable summary of the overall accessibility, which includes a description of any known deficiencies (e.g., lack of extended descriptions, specific hazards).
  ///
  /// The following example shows an accessibility summary for an EPUB 3 Publication that failed to meet the content accessibility requirements.
  ///
  /// ```
  /// <meta property="schema:accessibilitySummary">
  /// The publication is missing alternative text for complex diagrams.
  /// The publication otherwise meets WCAG 2.0 Level A.
  /// </meta>
  /// ```
  /// The following example shows an accessibility summary for an EPUB 3 Publication with a motion simulation hazard.
  ///
  /// ```
  /// <meta property="schema:accessibilitySummary">
  /// Chapter four contains a first-person interactive game that could cause
  /// motion sickness in certain individuals. The game is only provided for
  /// illustrative purposes, so readers unable to interact with it will not
  /// be at a disadvantage.
  /// </meta>
  /// ```
  final String? accessibilitySummary;

  static const kDefaultAccessibilitySummaryKey = 'default';

  /// Included summaries with the language as the key
  final Map<String, String>? accessibilitySummaryByLanguage;

  /// A set of one or more [AccessModesSufficient] to consume the content without significant loss of information.
  /// An EPUB Publication might have more than one set of sufficient access modes for its consumption depending
  /// on the types of content it includes (i.e., unlike [AccessMode], this property takes into account any affordances
  /// for content that is not broadly accessible, such as the inclusion of transcripts for audio content).
  final List<AccessModesSufficient>? accessModeSufficientList;

  /// Indicates the resource is compatible with the specified accessibility API.
  /// This property is typically only used to indicate that the use of scripting
  /// in an EPUB Publication follows [WAI-ARIA 1.1](https://www.w3.org/TR/wai-aria-1.1/) authoring practices, as
  /// compatibility with operating system accessibility APIs is a concern for Reading Systems.
  ///
  /// Users of Assistive Technologies are able to interact with EPUB Publications through the accessibility
  /// APIs built into whichever platform they use (Windows, Mac, iOS, Linux, etc.). These APIs allow the
  /// Assistive Technology to communicate with the Reading System to read the text or control the interface, as needed.
  ///
  /// Authors of static content do not have to worry about this interaction, as the user's Reading System exposes the
  /// necessary information to the accessibility APIs (provided it has been developed to be accessible). Authors who
  /// create EPUB Publications that contain dynamic content — such as scripting and custom controls — do need to pay
  /// attention to the compatibility of such content, as Assistive Technologies may not receive sufficient information
  /// to provide an accessible interface.
  ///
  /// In the case of scripted content, the static picture of the content that an Assistive Technology initially
  /// generates will not get updated unless the Author follows the accessibility practices in [WAI-ARIA 1.1](https://www.w3.org/TR/wai-aria-1.1/).
  /// Similarly, although Assistive Technologies have access to information about native [HTML](https://www.w3.org/TR/html/) form elements
  /// (e.g., buttons and inputs), Authors often create custom elements whose state is opaque without correct use
  /// of [WAI-ARIA 1.1](https://www.w3.org/TR/wai-aria-1.1/) roles, state and properties  (e.g., checkboxes made out of images). Users want to know that
  /// such content has been made compatible with Reading System that support ARIA.
  final List<AccessibilityAPI>? accessibilityAPIs;

  /// Identifies input methods that can be used to access the content (e.g., keyboard, mouse).
  final List<AccessibilityControl>? accessibilityControls;

  factory PackageFile.read(Archive archive) {
    return PackageReader.parse(archive);
  }

  PackageFile copyWith({
    List<AccessMode>? accessModes,
    List<AccessibilityFeature>? accessibilityFeatures,
    List<AccessibilityHazard>? accessibilityHazards,
    String? accessibilitySummary,
    Map<String, String>? accessibilitySummaryByLanguage,
    List<AccessModesSufficient>? accessModeSufficientList,
    List<AccessibilityAPI>? accessibilityAPIs,
    List<AccessibilityControl>? accessibilityControls,
  }) {
    return PackageFile(
      accessModes: accessModes ?? this.accessModes,
      accessibilityFeatures:
          accessibilityFeatures ?? this.accessibilityFeatures,
      accessibilityHazards: accessibilityHazards ?? this.accessibilityHazards,
      accessibilitySummary: accessibilitySummary ?? this.accessibilitySummary,
      accessibilitySummaryByLanguage:
          accessibilitySummaryByLanguage ?? this.accessibilitySummaryByLanguage,
      accessModeSufficientList:
          accessModeSufficientList ?? this.accessModeSufficientList,
      accessibilityAPIs: accessibilityAPIs ?? this.accessibilityAPIs,
      accessibilityControls:
          accessibilityControls ?? this.accessibilityControls,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accessModes': accessModes?.map((x) => x.name).toList(),
      'accessibilityFeatures':
          accessibilityFeatures?.map((x) => x.name).toList(),
      'accessibilityHazards': accessibilityHazards?.map((x) => x.name).toList(),
      'accessibilitySummary': accessibilitySummary,
      'accessibilitySummaryByLanguage': accessibilitySummaryByLanguage,
      'accessModeSufficientList': accessModeSufficientList
          ?.map(
            (accessModeSufficient) => accessModeSufficient.map(
              (accessMode) => accessMode.name,
            ),
          )
          .toList(),
      'accessibilityAPIs': accessibilityAPIs?.map((x) => x.name).toList(),
      'accessibilityControls':
          accessibilityControls?.map((x) => x.name).toList(),
    };
  }

  factory PackageFile.fromMap(Map<String, dynamic> map) {
    return PackageFile(
      accessModes: map['accessModes'] == null
          ? null
          : List<AccessMode>.from(
              map['accessModes']?.map((x) => AccessMode.values.byName(x)),
            ),
      accessibilityFeatures: map['accessibilityFeatures'] == null
          ? null
          : List<AccessibilityFeature>.from(
              map['accessibilityFeatures']
                  ?.map((x) => AccessibilityFeature.values.byName(x)),
            ),
      accessibilityHazards: map['accessibilityHazards'] == null
          ? null
          : List<AccessibilityHazard>.from(
              map['accessibilityHazards']
                  ?.map((x) => AccessibilityHazard.values.byName(x)),
            ),
      accessibilitySummary: map['accessibilitySummary'] ?? '',
      accessibilitySummaryByLanguage:
          map['accessibilitySummaryByLanguage'] == null
              ? null
              : Map<String, String>.from(
                  map['accessibilitySummaryByLanguage'],
                ),
      accessModeSufficientList: map['accessModeSufficientList'] == null
          ? null
          : List<AccessModesSufficient>.from(
              map['accessModeSufficientList']?.map(
                  (accessModeSufficientMap) => accessModeSufficientMap.map(
                        (accessModeMap) =>
                            AccessMode.values.byName(accessModeMap),
                      )),
            ),
      accessibilityAPIs: map['accessibilityAPIs'] == null
          ? null
          : List<AccessibilityAPI>.from(map['accessibilityAPIs']
              ?.map((x) => AccessibilityAPI.values.byName(x))),
      accessibilityControls: map['accessibilityControls'] == null
          ? null
          : List<AccessibilityControl>.from(map['accessibilityControls']
              ?.map((x) => AccessibilityControl.values.byName(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageFile.fromJson(String source) =>
      PackageFile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PackageMetadata(accessModes: $accessModes, accessibilityFeatures: $accessibilityFeatures, accessibilityHazards: $accessibilityHazards, accessibilitySummary: $accessibilitySummary, accessibilitySummaryByLanguage: $accessibilitySummaryByLanguage, accessModeSufficientList: $accessModeSufficientList, accessibilityAPIs: $accessibilityAPIs, accessibilityControls: $accessibilityControls)';
  }

  @override
  List<Object> get props {
    return [
      accessModes ?? [],
      accessibilityFeatures ?? [],
      accessibilityHazards ?? [],
      accessibilitySummary ?? '',
      accessibilitySummaryByLanguage ?? {},
      accessModeSufficientList ?? [],
      accessibilityAPIs ?? [],
      accessibilityControls ?? [],
    ];
  }
}
