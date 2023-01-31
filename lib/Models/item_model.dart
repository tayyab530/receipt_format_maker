import 'package:receipt_format_maker/Tables/items.dart';


class ItemData {
  final int id;
  final int formatId;
  final String? startingText;
  final int verticalLinesDownwards;
  final int horizontalCharacterRight;
  final int possibleLines;

  ItemData({
    required this.id,
    required this.formatId,
    this.startingText,
    required this.verticalLinesDownwards,
    required this.horizontalCharacterRight,
    required this.possibleLines,
  });

  ItemData.fromMap(Map<String, dynamic> row)
      : id = row[Items.id],
        formatId = row[Items.formatId],
        startingText = row[Items.startingText],
        verticalLinesDownwards = row[Items.verticalLinesDownwards],
        horizontalCharacterRight = row[Items.horizontalCharacterRight],
        possibleLines = row[Items.possibleLines];

  Map<String, dynamic> toMap() {
    return {
      Items.id: id,
      Items.formatId: formatId,
      Items.startingText: startingText,
      Items.verticalLinesDownwards: verticalLinesDownwards,
      Items.horizontalCharacterRight: horizontalCharacterRight,
      Items.possibleLines: possibleLines,
    };
  }
}
