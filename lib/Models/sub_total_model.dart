import 'dart:convert';

import 'package:receipt_format_maker/Tables/sub_total.dart';

class SubTotalData {
  final int id;
  final int formatId;
  final List<String> listOfLineIds;
  final String startingText;
  final int possibleLines;
  final int verticalLinesUpwards;

  SubTotalData({
    required this.id,
    required this.formatId,
    required this.listOfLineIds,
    required this.startingText,
    required this.possibleLines,
    required this.verticalLinesUpwards,
  });

  SubTotalData.fromMap(Map<String, dynamic> row)
      : id = row[SubTotals.id],
        formatId = row[SubTotals.formatId],
        listOfLineIds = List<String>.from(jsonDecode(row[SubTotals.listOfRowSequenceIds])),
        startingText = row[SubTotals.startingText],
        possibleLines = row[SubTotals.possibleLines],
        verticalLinesUpwards = row[SubTotals.verticalLinesUpwards];

  Map<String, dynamic> toMap() {
    return {
      SubTotals.id: id,
      SubTotals.formatId: formatId,
      SubTotals.listOfRowSequenceIds: listOfLineIds,
      SubTotals.startingText: startingText,
      SubTotals.possibleLines: possibleLines,
      SubTotals.verticalLinesUpwards: verticalLinesUpwards
    };
  }
}
