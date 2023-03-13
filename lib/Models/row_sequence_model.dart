import 'package:receipt_format_maker/Tables/row_sequence.dart';

import 'package:receipt_format_maker/Tables/row_sequence.dart';

import 'package:receipt_format_maker/Tables/row_sequence.dart';

import 'package:receipt_format_maker/Tables/row_sequence.dart';

import 'package:receipt_format_maker/Tables/row_sequence.dart';

import 'package:receipt_format_maker/Tables/row_sequence.dart';

import 'package:receipt_format_maker/Tables/row_sequence.dart';

class RowSeqData {
  final String id;
  final int seq;
  final int subSeq;
  final String rowType;
  final int verticalNavigationLines;
  final int horizontalNavigationCharacters;
  final String? startingText;
  static const initialRowId = "0";

  RowSeqData({
    required this.id,
    required this.seq,
    required this.subSeq,
    required this.rowType,
    required this.verticalNavigationLines,
    required this.horizontalNavigationCharacters,
    required this.startingText,
  });

  RowSeqData.fromMap(Map<String, dynamic> row)
      : id = row[RowSequence.id],
        seq = row[RowSequence.seq],
        subSeq = row[RowSequence.subSeq],
        rowType = row[RowSequence.rowType],
        verticalNavigationLines = row[RowSequence.verticalNavigationLines],
        horizontalNavigationCharacters = row[RowSequence.horizontalNavigationCharacters],
        startingText = row[RowSequence.startingText];

  Map<String, dynamic> toMap() {
    return {
      RowSequence.id: id,
      RowSequence.seq: seq,
      RowSequence.subSeq: subSeq,
      RowSequence.rowType: rowType,
      RowSequence.verticalNavigationLines: verticalNavigationLines,
      RowSequence.horizontalNavigationCharacters: horizontalNavigationCharacters,
      RowSequence.startingText: startingText,
    };
  }

  bool get isInitialRow => id == initialRowId ? true: false;

  bool get isStartingTextEmpty => startingText == null || startingText!.isEmpty ? true: false;
}
