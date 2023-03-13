import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:provider/provider.dart';
import 'package:receipt_format_maker/Models/block_model.dart';
import 'package:receipt_format_maker/Models/format_model.dart';
import 'package:receipt_format_maker/Models/row_sequence_model.dart';
import 'package:receipt_format_maker/Tables/blocks.dart';
import 'package:receipt_format_maker/Tables/format.dart';
import 'package:receipt_format_maker/Tables/items.dart';
import 'package:receipt_format_maker/Tables/row_sequence.dart';
import 'package:receipt_format_maker/Tables/sub_total.dart';
import 'package:receipt_format_maker/Tables/total.dart';
import 'package:receipt_format_maker/services/ocr.dart';

import '../Shared/functions.dart';
import '../Tables/tax.dart';
import '../services/image_picker_service.dart';
import '../services/ocr_service.dart';

///Home screen for the app
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var items = [
    'Tap to Add',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  late String dropDownValue;
  int numberOfRows = 1;
  bool isInitialized = false;

  var formatRow = {
    Formats.id: "1",
    Formats.name: "F_WallMart_CAD",
    Formats.noOfPossibleLines: 2,
  };

  List<Map<String, dynamic>> listOfRowSequence = [
    {
      RowSequence.id: "0",
      RowSequence.seq: "0",
      RowSequence.subSeq: "0",
      RowSequence.rowType: "StartingRow",
      RowSequence.verticalNavigationLines: 1,
      RowSequence.horizontalNavigationCharacters: 1,
      RowSequence.startingText: "ST#",
    },
    {
      RowSequence.id: "1",
      RowSequence.seq: "1",
      RowSequence.subSeq: "1",
      RowSequence.rowType: "Item",
      RowSequence.verticalNavigationLines: 1,
      RowSequence.horizontalNavigationCharacters: 0,
      RowSequence.startingText: "",
    },
    {
      RowSequence.id: "2",
      RowSequence.seq: "1",
      RowSequence.subSeq: "2",
      RowSequence.rowType: "Item",
      RowSequence.verticalNavigationLines: 1,
      RowSequence.horizontalNavigationCharacters: 0,
      RowSequence.startingText: "",
    },
    {
      RowSequence.id: "3",
      RowSequence.seq: "2",
      RowSequence.subSeq: "1",
      RowSequence.rowType: "SubTotal",
      RowSequence.verticalNavigationLines: 1,
      RowSequence.horizontalNavigationCharacters: -3,
      RowSequence.startingText: "SUBTOTAL",
    },
    {
      RowSequence.id: "4",
      RowSequence.seq: "3",
      RowSequence.subSeq: "1",
      RowSequence.rowType: "Tax",
      RowSequence.verticalNavigationLines: 1,
      RowSequence.horizontalNavigationCharacters: 8,
      RowSequence.startingText: "GST,HST",
    },
    {
      RowSequence.id: "5",
      RowSequence.seq: "4",
      RowSequence.subSeq: "1",
      RowSequence.rowType: "Total",
      RowSequence.verticalNavigationLines: 0,
      RowSequence.horizontalNavigationCharacters: 0,
      RowSequence.startingText: "TOTAL",
    },
  ];

  List<Map<String, dynamic>> listOfBlocks = [
    {
      Blocks.formatId: "1",
      Blocks.formatName: "F_WallMart_CAD",
      Blocks.rowSequenceID: 1,
      Blocks.blockSequence: 1,
      Blocks.blockId: "1",
      Blocks.dataType: 2,
      Blocks.dataTypeName: "Alphanumeric",
      Blocks.maxLength: 12,
      Blocks.isRequired: 1,
      Blocks.key: "Item",
    },
    {
      Blocks.formatId: "1",
      Blocks.formatName: "F_WallMart_CAD",
      Blocks.rowSequenceID: 1,
      Blocks.blockSequence: 2,
      Blocks.blockId: "2",
      Blocks.dataType: 1,
      Blocks.dataTypeName: "Numeric",
      Blocks.maxLength: 10,
      Blocks.isRequired: 0,
      Blocks.key: "None",
    },
    {
      Blocks.formatId: "1",
      Blocks.formatName: "F_WallMart_CAD",
      Blocks.rowSequenceID: 1,
      Blocks.blockSequence: 3,
      Blocks.blockId: "3",
      Blocks.dataType: 4,
      Blocks.dataTypeName: "Currency",
      Blocks.maxLength: 8,
      Blocks.isRequired: 1,
      Blocks.key: "Item Total Price",
    },
    {
      Blocks.formatId: "1",
      Blocks.formatName: "F_WallMart_CAD",
      Blocks.rowSequenceID: 1,
      Blocks.blockSequence: 4,
      Blocks.blockId: "4",
      Blocks.dataType: 1,
      Blocks.dataTypeName: "Alphabetic",
      Blocks.maxLength: 1,
      Blocks.isRequired: 1,
      Blocks.key: "Tax",
    },
    {
      Blocks.formatId: "1",
      Blocks.formatName: "F_WallMart_CAD",
      Blocks.rowSequenceID: 2,
      Blocks.blockSequence: 1,
      Blocks.blockId: "5",
      Blocks.dataType: 2,
      Blocks.dataTypeName: "Alphanumeric",
      Blocks.maxLength: 12,
      Blocks.isRequired: 1,
      Blocks.key: "Item",
    },
    {
      Blocks.formatId: "1",
      Blocks.formatName: "F_WallMart_CAD",
      Blocks.rowSequenceID: 2,
      Blocks.blockSequence: 2,
      Blocks.blockId: "6",
      Blocks.dataType: 1,
      Blocks.dataTypeName: "Numeric",
      Blocks.maxLength: 10,
      Blocks.isRequired: 0,
      Blocks.key: "None",
    },
    {
      Blocks.formatId: "1",
      Blocks.formatName: "F_WallMart_CAD",
      Blocks.rowSequenceID: 2,
      Blocks.blockSequence: 3,
      Blocks.blockId: "7",
      Blocks.dataType: 4,
      Blocks.dataTypeName: "Currency",
      Blocks.maxLength: 8,
      Blocks.isRequired: 1,
      Blocks.key: "Item Total Price",
    },
    {
      Blocks.formatId: "1",
      Blocks.formatName: "F_WallMart_CAD",
      Blocks.rowSequenceID: 2,
      Blocks.blockSequence: 4,
      Blocks.blockId: "8",
      Blocks.dataType: 1,
      Blocks.dataTypeName: "Alphabetic",
      Blocks.maxLength: 1,
      Blocks.isRequired: 1,
      Blocks.key: "Tax",
    },
    {
      Blocks.formatId: "1",
      Blocks.formatName: "F_WallMart_CAD",
      Blocks.rowSequenceID: 3,
      Blocks.blockSequence: 1,
      Blocks.blockId: "9",
      Blocks.dataType: 1,
      Blocks.dataTypeName: "Alphabetic",
      Blocks.maxLength: 7,
      Blocks.isRequired: 1,
      Blocks.key: "SubTotal",
    },
    {
      Blocks.formatId: "1",
      Blocks.formatName: "F_WallMart_CAD",
      Blocks.rowSequenceID: 3,
      Blocks.blockSequence: 2,
      Blocks.blockId: "10",
      Blocks.dataType: 4,
      Blocks.dataTypeName: "Currency",
      Blocks.maxLength: 10,
      Blocks.isRequired: 1,
      Blocks.key: "None",
    },
    {
      Blocks.formatId: "1",
      Blocks.formatName: "F_WallMart_CAD",
      Blocks.rowSequenceID: 4,
      Blocks.blockSequence: 1,
      Blocks.blockId: "11",
      Blocks.dataType: 1,
      Blocks.dataTypeName: "Alphabetic",
      Blocks.maxLength: 3,
      Blocks.isRequired: 1,
      Blocks.key: "GST",
    },
    {
      Blocks.formatId: "1",
      Blocks.formatName: "F_WallMart_CAD",
      Blocks.rowSequenceID: 4,
      Blocks.blockSequence: 2,
      Blocks.blockId: "12",
      Blocks.dataType: 5,
      Blocks.dataTypeName: "Percentage",
      Blocks.maxLength: 10,
      Blocks.isRequired: 1,
      Blocks.key: "GST Perc",
    },
    {
      Blocks.formatId: "1",
      Blocks.formatName: "F_WallMart_CAD",
      Blocks.rowSequenceID: 4,
      Blocks.blockSequence: 3,
      Blocks.blockId: "13",
      Blocks.dataType: 4,
      Blocks.dataTypeName: "Currency",
      Blocks.maxLength: 10,
      Blocks.isRequired: 1,
      Blocks.key: "GST",
    },
    {
      Blocks.formatId: "1",
      Blocks.formatName: "F_WallMart_CAD",
      Blocks.rowSequenceID: 5,
      Blocks.blockSequence: 1,
      Blocks.blockId: "14",
      Blocks.dataType: 1,
      Blocks.dataTypeName: "Alphabetic",
      Blocks.maxLength: 5,
      Blocks.isRequired: 1,
      Blocks.key: "TOTAL",
    },
    {
      Blocks.formatId: "1",
      Blocks.formatName: "F_WallMart_CAD",
      Blocks.rowSequenceID: 5,
      Blocks.blockSequence: 2,
      Blocks.blockId: "15",
      Blocks.dataType: 4,
      Blocks.dataTypeName: "Currency",
      Blocks.maxLength: 10,
      Blocks.isRequired: 1,
      Blocks.key: "TOTAL",
    },
  ];

  GlobalKey scaffoldKey = GlobalKey();

  @override
  void initState() {
    dropDownValue = items.first;
    initialization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Formatter"),
      ),
      // body: FutureBuilder(
      //     future: initialization(),
      //   builder: (context,ss) {
      //       if(ss.connectionState == ConnectionState.waiting) {
      //         return const CircularProgressIndicator();
      //       }
      //       else if(ss.hasError) {
      //         return const Text("Error Occurred");
      //       }
      //     return ListView.builder(
      //         itemCount: numberOfRows,
      //         itemBuilder: (context, index) {
      //           return formRow(index);
      //         });
      //   }
      // ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.scanner),
        onPressed: () {
          try {
            scan(context);
          } catch (e) {
            print(e.toString());
          }
        },
      ),
    );
  }

  Future<void> initialization() async {
    if (!isInitialized) {
      // await createDB();
      await deleteAllDataFromTables();

      await Formats.instance.insert(formatRow);

      for (var rowSequenceRow in listOfRowSequence) {
        await RowSequence.instance.insert(rowSequenceRow);
      }
      for (var blockRow in listOfBlocks) {
        await Blocks.instance.insert(blockRow);
      }

      isInitialized = true;
    }
  }

  formRow(int index) {
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: mediaQuery.height * 0.05,
      padding: EdgeInsets.only(
          left: 10, top: 5, bottom: 5, right: mediaQuery.width * 0.7),
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Colors.grey, style: BorderStyle.solid)),
        // color: Colors.orangeAccent,
      ),
      child: DropdownButton<String>(
        // Initial Value
        value: dropDownValue,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            dropDownValue = newValue!;
            numberOfRows++;
          });
        },
      ),
    );
  }

  void scan(BuildContext ctx) async {
    try {
      var prvOcrService = Provider.of<PrvOcrService>(context, listen: false);
      var image = await getImage(ctx);

      List<TextElement> elements;

      if (image != null) {
        elements = await prvOcrService.scan(image);
        FormatData? formatData = await getFormat("1");

        if (formatData != null) {
          prvOcrService.saveElementsToDB(formatData.id);

          List<RowSeqData> listOfRowSequences =
              await getRowSequences(formatData!.id);
          if (listOfRowSequences.isNotEmpty) {
            int i = 0;
            for (var rowSeqData in listOfRowSequences) {
              var currentRowSeqId = rowSeqData.id;
              var listOfRowSequencesWithStartingText = listOfRowSequences
                  .where((element) =>
                      element.startingText != null &&
                      element.startingText!.isNotEmpty)
                  .toList();
              var nextRowSeqStartingText =
                  getTheNextSeqText(listOfRowSequencesWithStartingText, i);
              if (rowSeqData.isInitialRow) {
                // when it is initial row
                if (!rowSeqData.isStartingTextEmpty) {
                  // when starting text is not empty
                  var startingElement =
                      searchElements(elements, rowSeqData.startingText!);

                  if (startingElement != null) {
                    //when there block is found
                    var elementCoordinates = startingElement.cornerPoints;
                    prvOcrService
                        .updateVerticalPointer(elementCoordinates.first);
                    prvOcrService
                        .updateHorizontalPointer(elementCoordinates.first);
                    var nextRowSeqId = listOfRowSequences[i + 1]
                        .id; // implement if not last item in the list
                    var listOfBlocks = await BlockData.getBlocksFromDB(
                        currentRowSeqId); // list of blocks from Block table

                    // while (!prvOcrService.hasCursorReachedGivenTag(
                    //     nextRowSeqStartingText ?? "")) {
                    //   traverseBlocks(
                    //       listOfBlocks, elements, nextRowSeqStartingText,
                    //       startingTextElement: startingElement);
                    // }
                  } else {
                    //when there block is not found

                  }
                } else {
                  // when starting text is empty
                  var listOfBlocks = BlockData.getBlocksFromDB(
                      currentRowSeqId); // list of blocks from Block table
                }
              } else {
                // when it is not initial row
                var listOfBlocks = await BlockData.getBlocksFromDB(
                    currentRowSeqId); // list of blocks from Block table

                traverseBlocks(
                  listOfBlocks,
                  elements,
                  nextRowSeqStartingText,
                );
              }

              //next sequence does not exist
              if (i == listOfRowSequence.length - 1) {
                //TODO: Apply condition for end of Y_Axis
                break;
              }
              i++;
            }
          } else {
            showError(scaffoldContext, "No row sequences found");
          }
        } else {
          showError(scaffoldContext, "Could not find specified format");
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  String getTheNextSeqText(List<RowSeqData> list, int currentIndex) {
    for (int i = currentIndex; i < list.length; i++) {
      if (list[i].startingText != null && list[i].startingText!.isNotEmpty) {
        return list[i].startingText!;
      }
    }
    return "";
  }

  Future<InputImage?> getImage(BuildContext context) async {
    var prvImagePickerService =
        Provider.of<ImagePickerService>(context, listen: false);

    return prvImagePickerService.getImageFromGallery();
  }

  Future<FormatData?> getFormat(String fId) async {
    try {
      var formatRow =
          (await Formats.instance.queryonlyRows(fId, Formats.id)).first;
      return FormatData.fromMap(formatRow);
    } catch (e, s) {
      print(e);
      return null;
    }
  }

  Future<List<RowSeqData>> getRowSequences(String fId) async {
    try {
      var rowSeqRows = await RowSequence.instance.queryAllRows();
      return rowSeqRows.map((row) => RowSeqData.fromMap(row)).toList();
    } catch (e, s) {
      print(e);
      return <RowSeqData>[];
    }
  }

  TextElement? searchElements(
      List<TextElement> listOfElements, String startingText) {
    TextElement? textElement;
    textElement = listOfElements
        .firstWhere((element) => element.text.contains(startingText));
    return textElement;
  }

  void traverseBlocks(List<BlockData> listOfBlocks, List<TextElement> elements,
      String? nextRowSeqStartingText,
      {TextElement? startingTextElement}) {
    var prvOCRService =
        Provider.of<PrvOcrService>(scaffoldContext, listen: false);
    var originalList = listOfBlocks;
    var sortedListOfBlocks = BlockData.sortBlocksByBlockSeq(listOfBlocks);

    if (startingTextElement != null) {
// when we have starting TextElement

      var startingSearchLinePoint = startingTextElement.cornerPoints.first;

      for (var block in sortedListOfBlocks) {
        var charWidth = PrvOcrService.getCharacterWidth(block);
        var totalWidth = PrvOcrService.calculateTotalWidthElement(
            block.maxLength.toDouble(), charWidth);
        prvOCRService.updateVerticalPointer(startingSearchLinePoint);
        prvOCRService.updateHorizontalPointer(startingSearchLinePoint);
        bool isRequired = block.isRequired;

        if (isRequired) {
          prvOCRService.traverseElementsHorizontally(isRequired, block);
        }
      }
    } else {
      // when we don't have starting TextElement
      while (!prvOCRService
          .hasCursorReachedGivenTag(nextRowSeqStartingText ?? "")) {
        for (var block in sortedListOfBlocks) {
          var charWidth = PrvOcrService.getCharacterWidth(block);
          var totalWidth = PrvOcrService.calculateTotalWidthElement(
              block.maxLength.toDouble(), charWidth);
          bool isRequired = block.isRequired;

          prvOCRService.traverseElementsHorizontally(isRequired, block);
        }
        prvOCRService.updateVerticalPointer(Point(
            prvOCRService.currentCursorPointVertically.x,
            prvOCRService.currentCursorPointVertically.y + 100));
      }
    }
  }

  bool hasReachedNextSeq(String startingSeqText) {
    var prvOCRService = Provider.of<PrvOcrService>(context, listen: false);

    return prvOCRService.hasCursorReachedGivenTag(startingSeqText);
  }

  BuildContext get scaffoldContext => scaffoldKey.currentContext!;
}
