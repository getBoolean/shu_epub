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
