part of shu_epub.controllers;

mixin ContentMixin {
  XmlElement get element;

  EpubNavigationContent? getContent() {
    throw UnimplementedError();
  }
}
