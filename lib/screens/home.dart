import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:receipt_format_maker/Tables/blocks.dart';
import 'package:receipt_format_maker/Tables/format.dart';
import 'package:receipt_format_maker/Tables/items.dart';
import 'package:receipt_format_maker/Tables/lines.dart';
import 'package:receipt_format_maker/Tables/sub_total.dart';
import 'package:receipt_format_maker/Tables/total.dart';

import '../Shared/functions.dart';
import '../Tables/tax.dart';

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
    Formats.startingText: "ST#",
    Formats.startingTextPredecessor: "Item",
    Formats.verticalNavigationLines: 1,
    Formats.horizontalNavigationCharacters: 1,
  };


  List<Map<String,dynamic>> listOfItems = [
    {
      Items.id: "1",
      Items.formatId: "1",
      Items.startingText: "",
      Items.verticalNavigationLines: 2,
      Items.horizontalNavigationCharacters: 8,
      Items.possibleLines: 2,
    },
    // {
    //   Items.id: "1",
    //   Items.formatId: "0",
    //   Items.lineType: 0,
    //   Items.startingText: "",
    //   Items.verticalLinesDownwards: 1,
    //   Items.horizontalCharacterRight: 1,
    //   Items.possibleLines: 1,
    //   Items.listOfBlocks: ,
    // }
  ];

  List<Map<String,dynamic>> listOfLines = [
    {
      RowSequence.id: "1",
      RowSequence.seq: "1",
      RowSequence.subSeq: "1",
      RowSequence.rowType: "Item",
      RowSequence.verticalNavigationLines: 1,
      RowSequence.horizontalNavigationCharacters: 0,
    },
    {
      RowSequence.id: "2",
      RowSequence.seq: "1",
      RowSequence.subSeq: "2",
      RowSequence.rowType: "Item",
      RowSequence.verticalNavigationLines: 1,
      RowSequence.horizontalNavigationCharacters: 0,
    },
    {
      RowSequence.id: "3",
      RowSequence.seq: "2",
      RowSequence.subSeq: "1",
      RowSequence.rowType: "SubTotal",
      RowSequence.verticalNavigationLines: 2,
      RowSequence.horizontalNavigationCharacters: 8,
    },
    {
      RowSequence.id: "4",
      RowSequence.seq: "3",
      RowSequence.subSeq: "1",
      RowSequence.rowType: "Tax",
      RowSequence.verticalNavigationLines: 1,
      RowSequence.horizontalNavigationCharacters: -3,
    },
    {
      RowSequence.id: "5",
      RowSequence.seq: "4",
      RowSequence.subSeq: "1",
      RowSequence.rowType: "Total",
      RowSequence.verticalNavigationLines: 1,
      RowSequence.horizontalNavigationCharacters: 8,
    },
  ];

  List<Map<String,dynamic>> listOfBlocks = [
    {
      Blocks.formatId: "1",
      Blocks.formatName: "F_WallMart_CAD",
      Blocks.rowSequenceID: 1,
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
      Blocks.blockId: "15",
      Blocks.dataType: 4,
      Blocks.dataTypeName: "Currency",
      Blocks.maxLength: 10,
      Blocks.isRequired: 1,
      Blocks.key: "TOTAL",
    },
  ];

  Map<String,dynamic> subTotal = {
    SubTotals.id: "1",
    SubTotals.formatId: "1",
    SubTotals.listOfRowSequenceIds: jsonEncode(["3"]),
    SubTotals.startingText: "SUBTOTAL",
    SubTotals.possibleLines: 1,
    SubTotals.verticalLinesUpwards: 2,
  };

  Map<String,dynamic> tax = {
    Tax.id: "1",
    Tax.formatId: "1",
    Tax.listOfLineIds: jsonEncode(["4"]),
    Tax.startingText: "GST",
    Tax.possibleLines: 1,
    Tax.verticalLinesUpwards: 1,
  };


  Map<String,dynamic> total = {
    Total.id: "1",
    Total.formatId: "1",
    Total.listOfLineIds: jsonEncode(["5"]),
    Total.startingText: "TOTAL",
    Total.possibleLines: 1,
    Total.verticalLinesUpwards: 0,
  };

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
    );
  }

  Future<void> initialization() async{
    if(!isInitialized) {
      // await createDB();
      await deleteAllDataFromTables();

      await Formats.instance.insert(formatRow);

      for (var itemRow in listOfItems) {
        await Items.instance.insert(itemRow);
      }
      for (var lineRow in listOfLines) {
        await RowSequence.instance.insert(lineRow);
      }
      for (var blockRow in listOfBlocks) {
        await Blocks.instance.insert(blockRow);
      }

      await SubTotals.instance.insert(subTotal);
      await Tax.instance.insert(tax);
      await Total.instance.insert(total);

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

}
