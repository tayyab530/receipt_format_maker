class OCRService{
  double? _charHeight;
  double? _charWidth;
  List<dynamic> data;

  OCRService({required this.data});

  double getCharHeight() => _charHeight ?? 0.0;
  double getCharWidth() => _charWidth ?? 0.0;


}