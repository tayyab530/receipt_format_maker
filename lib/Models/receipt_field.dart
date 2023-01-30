///Model class for receipt dropdown field
class ReceiptField{
  late String id;
  late String text;
  late bool isInitial;
  late int noOfPossibleLines;

}

enum FieldType{
  initial,
  items,

}