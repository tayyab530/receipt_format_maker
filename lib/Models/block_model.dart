import 'package:receipt_format_maker/Tables/blocks.dart';



class BlockData {
  final int id;
  final int lineId;
  final String dataType;
  final int maxLength;
  final bool isRequired;
  final String? key;

  BlockData({
    required this.id,
    required this.lineId,
    required this.dataType,
    required this.maxLength,
    required this.isRequired,
    this.key,
  });

  BlockData.fromMap(Map<String, dynamic> row):
    id = row[Blocks.blockId],
    lineId = row[Blocks.rowSequenceID],
    dataType = row[Blocks.dataType],
    maxLength = row[Blocks.maxLength],
    isRequired = row[Blocks.isRequired],
    key = row[Blocks.key];

  Map<String, dynamic> toMap() {
    return {
      Blocks.blockId: id,
      Blocks.rowSequenceID: lineId,
      Blocks.dataType: dataType,
      Blocks.maxLength: maxLength,
      Blocks.isRequired: isRequired,
      Blocks.key: key
    };
  }
}
