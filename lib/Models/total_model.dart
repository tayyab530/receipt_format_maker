import 'dart:convert';

import 'package:receipt_format_maker/Tables/total.dart';

class TotalData {
  final int id;
  final int formatId;
  final String startingText;
  final List<String> listOfLineIds;
  final int possibleLines;
  final int verticalLinesUpwards;

  TotalData({
    required this.id,
    required this.formatId,
    required this.startingText,
    required this.listOfLineIds,
    required this.possibleLines,
    required this.verticalLinesUpwards,
  });

  TotalData.fromMap(Map<String, dynamic> row)
      : id = row[Total.id],
        formatId = row[Total.formatId],
        startingText = row[Total.startingText],
        listOfLineIds = List<String>.from(jsonDecode(row[Total.listOfLineIds])),
        possibleLines = row[Total.possibleLines],
        verticalLinesUpwards = row[Total.verticalLinesUpwards];

  Map<String, dynamic> toMap() {
    return {
      Total.id: id,
      Total.formatId: formatId,
      Total.startingText: startingText,
      Total.listOfLineIds: listOfLineIds,
      Total.possibleLines: possibleLines,
      Total.verticalLinesUpwards: verticalLinesUpwards,
    };
  }
}
