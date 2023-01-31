import 'package:receipt_format_maker/Tables/format.dart';


class FormatData {
  final int id;
  final String name;
  final int noOfPossibleLines;
  final String startingText;
  final String startingTextPredecessor;

  FormatData({
    required this.id,
    required this.name,
    required this.noOfPossibleLines,
    required this.startingText,
    required this.startingTextPredecessor,
  });

  FormatData.fromMap(Map<String, dynamic> row):
    id = row[Formats.id],
    name = row[Formats.name],
    noOfPossibleLines = row[Formats.noOfPossibleLines],
    startingText = row[Formats.startingText],
    startingTextPredecessor = row[Formats.startingTextPredecessor];

  Map<String, dynamic> toMap() {
    return {
      Formats.id: id,
      Formats.name: name,
      Formats.noOfPossibleLines: noOfPossibleLines,
      Formats.startingText: startingText,
      Formats.startingTextPredecessor: startingTextPredecessor,
    };
  }
}
