import 'package:receipt_format_maker/Tables/blocks.dart';

import 'package:receipt_format_maker/Tables/blocks.dart';

import 'package:receipt_format_maker/Tables/blocks.dart';

import 'package:receipt_format_maker/Tables/blocks.dart';

import 'package:receipt_format_maker/Tables/blocks.dart';

import 'package:receipt_format_maker/Tables/blocks.dart';

import 'package:receipt_format_maker/Tables/blocks.dart';

import 'package:receipt_format_maker/Tables/blocks.dart';

import 'package:receipt_format_maker/Tables/blocks.dart';

import 'package:receipt_format_maker/Tables/blocks.dart';

class BlockData {
  final String formatId;
  final String formatName;
  final String rowSequenceID;
  final int blockSequence;
  final String blockId;
  final int dataType;
  final String dataTypeName;
  final int maxLength;
  final bool isRequired;
  final String key;

  BlockData({
    required this.formatId,
    required this.formatName,
    required this.rowSequenceID,
    required this.blockSequence,
    required this.blockId,
    required this.dataType,
    required this.dataTypeName,
    required this.maxLength,
    required this.isRequired,
    required this.key,
  });

  BlockData.fromMap(Map<String, dynamic> map)
      : formatId = map[Blocks.formatId],
        formatName = map[Blocks.formatName],
        rowSequenceID = map[Blocks.rowSequenceID],
        blockSequence = map[Blocks.blockSequence],
        blockId = map[Blocks.blockId],
        dataType = map[Blocks.dataType],
        dataTypeName = map[Blocks.dataTypeName],
        maxLength = map[Blocks.maxLength],
        isRequired = map[Blocks.isRequired] == 0 ? false: true,
        key = map[Blocks.key];

  Map<String, dynamic> toMap() {
    return {
      Blocks.formatId: formatId,
      Blocks.formatName: formatName,
      Blocks.rowSequenceID: rowSequenceID,
      Blocks.blockSequence: blockSequence,
      Blocks.blockId: blockId,
      Blocks.dataType: dataType,
      Blocks.dataTypeName: dataTypeName,
      Blocks.maxLength: maxLength,
      Blocks.isRequired: isRequired ? 1: 0,
      Blocks.key: key,
    };
  }

  static Future<List<BlockData>> getBlocksFromDB(String rowSeqId) async{
    var blocks = (await Blocks.instance.queryonlyRows(rowSeqId, Blocks.rowSequenceID));
    var blocksData = blocks.map((blockRow) => BlockData.fromMap(blockRow)).toList();
    return blocksData;
  }

  static List<BlockData> sortBlocksByBlockSeq(List<BlockData> listOfBlocks) {
    var newListOfBlocks = [...listOfBlocks];//creating new list
    newListOfBlocks.sort((a, b) => a.blockSequence.compareTo(b.blockSequence),); //sorting by blocks seq id
    return newListOfBlocks;
  }

  bool isInitialBlock() => blockSequence == 1 ? true:false;
}
