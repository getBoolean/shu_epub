part of shu_epub.enums;

/// In order for a user to determine whether an EPUB Publication is suitable for their needs,
/// they need to know which of these access modes are required to consume the content.
///
/// The following example shows the metadata entries for an EPUB 3 Publication that has textual and visual access modes.
///
/// ```html
/// <meta property="schema:accessMode">textual</meta>
/// <meta property="schema:accessMode">visual</meta>
/// ```
///
/// Note that the access modes of the content do not reflect any adaptations that have been provided.
/// For example, if a comic book also includes alternative text for each image, it does not have a
/// textual access mode. See the following section on sufficient access modes for how to indicate
/// that the available adaptations allow the content to be consumed in another mode.
///
/// http://idpf.org/epub/a11y/techniques/#meta-001
enum AccessMode {
  /// The publication contains text content (headings, paragraphs, etc.).
  textual,

  /// The publication contains visual content such as images, graphics, diagrams, animations and video.
  visual,

  /// The publication contains auditory content such as standalone audio clips and audio soundtracks for video content.
  auditory,

  /// The publication contains tactile content such as embedded braille and tactile diagrams.
  tactile,
}

extension AccessModeExtension on AccessMode {
  /// The string equivalent of this constant property used in EPUBs
  String get value {
    switch (this) {
      case AccessMode.textual:
        return 'texual';
      case AccessMode.visual:
        return 'visual';
      case AccessMode.auditory:
        return 'auditory';
      case AccessMode.tactile:
        return 'tactile';
    }
  }
}

/// The access modes sufficient to consume an EPUB Publication.
///
/// Where the basic access modes identify the default nature of the media used in the publication,
/// sufficient access modes identify which modes, or sets of modes, a user requires to read the publication.
/// Sufficient access modes take into account the affordances and adaptations that have been provided,
/// allowing a user to determine whether the content will be usable regardless of its default nature.
///
/// The order in which the access modes are listed is not important.
///
/// Note that sufficiency of access is often a subjective determination of the Author based on their understanding
/// of what information is essential to comprehending the text. Some information loss occurs by not being able to
/// view a video, for example, but the Author might regard the visual or auditory losses as inconsequential if a
/// transcript provides all the necessary information to understand the concepts being conveyed.
///
/// Example usage
///
/// ```html
/// <meta property="schema:accessMode">textual</meta>
/// <meta property="schema:accessMode">visual</meta>
/// <meta property="schema:accessModeSufficient">textual,visual</meta>
/// <meta property="schema:accessModeSufficient">textual</meta>
/// ```
///
/// http://idpf.org/epub/a11y/techniques/#meta-002
typedef AccessModesSufficient = List<AccessMode>;
