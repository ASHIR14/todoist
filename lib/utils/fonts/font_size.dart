enum FontSize {
  small(0.75),
  medium(1.0),
  big(1.2);

  const FontSize(this.scaleFactor);

  final double scaleFactor;

  static FontSize fromStr(String str) {
    return FontSize.values.firstWhere(
      (element) => element.name.toLowerCase() == str.toLowerCase(),
      orElse: () => FontSize.medium,
    );
  }
}
