part of shu_epub.controllers;

mixin TextImageMixin {
  XmlElement get element;
  
  String? getText() {
    throw UnimplementedError();
  }

  EpubNavigationImage? getImage() {
    throw UnimplementedError();
  }
}
