import 'package:receipt_format_maker/Tables/lines.dart';



class LineData extends Object{
  final int id;
  final int itemId;
  final int lineType;
  final int verticalLinesDownwards;
  final int horizontalCharacterRight;

  LineData({
    required this.id,
    required this.itemId,
    required this.lineType,
    required this.verticalLinesDownwards,
    required this.horizontalCharacterRight,
  });

  LineData.fromMap(Map<String, dynamic> row):
    id = row[RowSequence.id],
    itemId = row[RowSequence.rowType],
    lineType = row[RowSequence.subSeq],
    verticalLinesDownwards = row[RowSequence.verticalNavigationLines],
    horizontalCharacterRight = row[RowSequence.horizontalNavigationCharacters];

  Map<String, dynamic> toMap() {
    return {
      RowSequence.id: id,
      RowSequence.rowType: itemId,
      RowSequence.subSeq: lineType,
      RowSequence.verticalNavigationLines: verticalLinesDownwards,
      RowSequence.horizontalNavigationCharacters: horizontalCharacterRight
    };
  }


}
