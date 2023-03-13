// import 'dart:convert';
//
// import 'package:receipt_format_maker/Tables/tax.dart';
//
// class TaxData {
//   final int id;
//   final int formatId;
//   final List<String> listOfLineIds;
//   final String startingText;
//   final int possibleLines;
//   final int verticalLinesUpwards;
//
//   TaxData({
//     required this.id,
//     required this.formatId,
//     required this.listOfLineIds,
//     required this.startingText,
//     required this.possibleLines,
//     required this.verticalLinesUpwards,
//   });
//
//   TaxData.fromMap(Map<String, dynamic> row):
//     id = row[Tax.id],
//     formatId = row[Tax.formatId],
//     listOfLineIds = List<String>.from(jsonDecode(row[Tax.listOfLineIds])),
//     startingText = row[Tax.startingText],
//     possibleLines = row[Tax.possibleLines],
//     verticalLinesUpwards = row[Tax.verticalLinesUpwards];
//
//   Map<String, dynamic> toMap() {
//     return {
//       Tax.id: id,
//       Tax.formatId: formatId,
//       Tax.listOfLineIds: listOfLineIds,
//       Tax.startingText: startingText,
//       Tax.possibleLines: possibleLines,
//       Tax.verticalLinesUpwards: verticalLinesUpwards
//     };
//   }
// }
