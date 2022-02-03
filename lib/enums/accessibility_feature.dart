/// The accessibilityFeature property provides a list of all the applicable accessibility characteristics of the content.
/// It allows a user agent to discover these characteristics without having to parse or interpret the structure of the content.
///
/// https://www.w3.org/2021/a11y-discov-vocab/latest/#accessibilityFeature
enum AccessibilityFeature {
  // ******************** Structure and Navigation Terms ********************
  // The structure and navigation term identify structuring and navigation aids that facilitate use of the work.

  /// The work includes annotations from the author, instructor and/or others.
  annotations,

  /// The work includes bookmarks to facilitate navigation to key points.
  bookmarks,

  /// The work includes an index to the content.
  ///
  /// Actual text used is `index` but that can't be used in an enum
  contentIndex,

  /// The work includes equivalent print page numbers. This setting is most commonly used with ebooks for which there is a print equivalent.
  printPageNumbers,

  /// The reading order of the content is clearly defined in the markup (e.g., figures, sidebars and
  /// other secondary content has been marked up to allow it to be skipped automatically and/or manually escaped from.
  readingOrder,

  /// The use of headings in the work fully and accurately reflects the document hierarchy, allowing navigation by assistive technologies.
  structuralNavigation,

  /// The structures in a PDF have been tagged to improve the navigation of the content.
  taggedPDF,

  // ************************* Adaptation Terms *************************
  // The adaptation terms identify provisions in the content that enable reading in alternative access modes.

  /// Alternative text is provided for visual content (e.g., via the HTML [alt attribute](https://html.spec.whatwg.org/multipage/embedded-content.html#attr-img-alt)).
  alternativeText,

  /// Audio descriptions are available (e.g., via an HTML track element with its kind attribute set to "descriptions").
  audioDescription,

  /// Indicates that synchronized captions are available for audio and video content.
  captions,

  /// Textual descriptions of math equations are included, whether in the alt attribute for image-based equations,
  /// using the alttext attribute for [MathML] equations, or by other means.
  describedMath,

  /// Descriptions are provided for image-based visual content and/or complex structures such as
  /// tables, mathematics, diagrams, and charts.
  ///
  /// NOTE: Authors may set this property independent of the method they use to provide the extended
  /// descriptions (i.e., it is not required to use the obsolete HTML [longdesc attribute](https://html.spec.whatwg.org/multipage/obsolete.html#attr-img-longdesc)).
  longDescription,

  /// Indicates that [ruby annotations](https://html.spec.whatwg.org/multipage/text-level-semantics.html#the-ruby-element) HTML are provided in the content. Ruby annotations are used
  /// as pronunciation guides for the logographic characters for languages like Chinese or Japanese.
  /// It makes difficult Kanji or CJK ideographic characters more accessible.
  ///
  /// The absence of rubyAnnotations implies that no CJK ideographic characters have ruby.
  rubyAnnotations,

  /// Sign language interpretation is available for audio and video content. The value may be extended
  /// by adding an [ISO-639](https://www.w3.org/2021/a11y-discov-vocab/latest/#bib-iso-639) sign language code. For example, /sgn-en-us for American Sign Language.
  signLanguage,

  /// Indicates that a transcript of the audio content is available.
  transcript,

  // ************************* Rendering Control Terms *************************
  // The rendering control values identify that access to a resource and rendering and playback of its content can be controlled for easier reading.

  /// Display properties are controllable by the user. This property can be set, for example, if custom CSS style sheets can be applied to the content to control the appearance. It can also be used to indicate that styling in document formats like Word and PDF can be modified.
  ///
  /// This property can be modified to identify the specific display properties that allow meaningful control. Modifiers should take the form of CSS property names, even if CSS is not the document styling format:
  ///
  /// * `/font-size`
  /// * `/font-family`
  /// * `/line-height`
  /// * `/word-spacing`
  /// * `/color`
  /// * `/background-color`
  ///
  /// Note that many CSS display properties can be modified, but not all usefully enhance the accessibility (e.g., image-based content).
  displayTransformability,

  /// Describes a resource that offers both audio and text, with information that allows them to be rendered simultaneously.
  /// The granularity of the synchronization is not specified. This term is not recommended when the only material that
  /// is synchronized is the document headings.
  synchronizedAudioText,

  /// For content with timed interaction, this value indicates that the user can control the timing to meet their needs (e.g., pause and reset)
  timingControl,

  /// No digital rights management (DRM) or other content restriction protocols have been applied to the resource.
  unlocked,

  // ************************* Specialized Markup Terms *************************
  // The specialized markup terms identify content available in specialized markup grammars. These grammars
  // typically provide users with enhanced structure and navigation capabilities.

  /// Identifies that chemical information is encoded using the [ChemML markup language](https://hachmannlab.github.io/chemml/).
  chemML,

  /// Identifies that mathematical equations and formulas are encoded in the [LaTeX typesetting system](https://www.latex-project.org/).
  latex,

  /// Identifies that mathematical equations and formulas are encoded in [MathML](https://www.w3.org/2021/a11y-discov-vocab/latest/#bib-mathml).
  mathML,

  /// One or more of [SSML](https://www.w3.org/2021/a11y-discov-vocab/latest/#bib-ssml),
  /// [Pronunciation-Lexicon](https://www.w3.org/2021/a11y-discov-vocab/latest/#bib-pronunciation-lexicon),
  /// and [CSS3-Speech](https://www.w3.org/2021/a11y-discov-vocab/latest/#bib-css3-speech) properties has been used to enhance text-to-speech playback quality.
  ttsMarkup,

  // ****************************** Clarity Terms ******************************
  // The clarity terms identify ways that the content has been enhanced for improved auditory or visual clarity.

  /// Audio content with speech in the foreground meets the contrast thresholds set out in [WCAG Success Criteria 1.4.7](https://www.w3.org/WAI/WCAG21/Understanding/low-or-no-background-audio).
  /// The requirement the audio meets can be appended, but is not required:
  ///
  /// * `/noBackground` - no background noise is present
  /// * `/reducedBackground` - at least 20db difference between foreground speech and background noise
  /// * `/switchableBackground` - background noise can be turned off (sufficient contrast may not be met without doing so)
  highContrastAudio,

  /// Content meets the visual contrast threshold set out in [WCAG Success Criteria 1.4.6](https://www.w3.org/WAI/WCAG21/Understanding/contrast-enhanced).
  highContrastDisplay,

  /// The content has been formatted to meet large print guidelines. The specific point size may optionally be added as an extension (e.g., `largePrint/18`).
  ///
  /// The property is not set if the font size can be increased. See [AccessibilityFeature.displayTransformability].
  largePrint,

  // ****************************** Tactile Terms ******************************
  // The tactile terms identify content that is available in tactile form.

  /// The content is in braille format, or alternatives are available in braille. This value can be extended
  /// to identify the different types of braille (`/ASCII`, `/unicode`, `/music`, `/math`, `/chemistry` or `/nemeth`),
  /// and whether the braille is contracted or not (`/grade1` and `/grade2`). Other extensions such as the code
  /// the braille conforms to can also be specified.
  braille,

  /// When used with creative works such as books, indicates that the resource includes tactile graphics.
  ///
  /// When used to describe an image resource or physical object, indicates that the resource is a tactile graphic.
  ///
  /// NOTE: Refer to the [BANA Guidelines and Standards for Tactile Graphics](http://www.brailleauthority.org/tg/)
  /// for more information about tactile graphic formats and formatting.
  tactileGraphic,

  /// When used with creative works such as books, indicates that the resource includes models to generate tactile 3D objects.
  ///
  /// When used to describe a physical object, indicates that the resource is a tactile 3D object.
  tactileObject,

  /// Indicates that the resource does not contain any accessibility features.
  none,
}
