part of shu_epub.controllers;

mixin LabelListMixin {
  XmlElement get element;

  List<EpubNavigationLabel> getLabels() {
    throw UnimplementedError();
  }
}
