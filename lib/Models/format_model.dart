import 'package:receipt_format_maker/Tables/format.dart';

import 'package:receipt_format_maker/Tables/format.dart';

import 'package:receipt_format_maker/Tables/format.dart';

class FormatData {
  final String id;
  final String name;
  final int noOfPossibleLines;

  FormatData({
    required this.id,
    required this.name,
    required this.noOfPossibleLines,
  });

  FormatData.fromMap(Map<String, dynamic> row)
      : id = row[Formats.id],
        name = row[Formats.name],
        noOfPossibleLines = row[Formats.noOfPossibleLines];

  Map<String, dynamic> toMap() {
    return {
      Formats.id: id,
      Formats.name: name,
      Formats.noOfPossibleLines: noOfPossibleLines,
    };
  }
}
