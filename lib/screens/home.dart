import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:receipt_format_maker/Tables/blocks.dart';
import 'package:receipt_format_maker/Tables/format.dart';
import 'package:receipt_format_maker/Tables/items.dart';
import 'package:receipt_format_maker/Tables/items.dart';
import 'package:receipt_format_maker/Tables/items.dart';
import 'package:receipt_format_maker/Tables/items.dart';
import 'package:receipt_format_maker/Tables/items.dart';
import 'package:receipt_format_maker/Tables/items.dart';
import 'package:receipt_format_maker/Tables/items.dart';
import 'package:receipt_format_maker/Tables/items.dart';
import 'package:receipt_format_maker/Tables/lines.dart';
import 'package:receipt_format_maker/Tables/sub_total.dart';
import 'package:receipt_format_maker/Tables/total.dart';
import 'package:receipt_format_maker/Tables/total.dart';
import 'package:receipt_format_maker/Tables/total.dart';
import 'package:receipt_format_maker/Tables/total.dart';
import 'package:receipt_format_maker/Tables/total.dart';
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
    Formats.id: "0",
    Formats.name: "F1",
    Formats.noOfPossibleLines: 1,
    Formats.listOfBlock: "",
    Formats.startingText: "",
    Formats.startingTextPredecessor: "",
  };


  List<Map<String,dynamic>> listOfItems = [
    {
      Items.id: "0",
      Items.formatId: "0",
      Items.lineType: 0,
      Items.startingText: "",
      Items.verticalLinesDownwards: 1,
      Items.horizontalCharacterRight: 1,
      Items.possibleLines: 1,
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
      Lines.id: "0",
      Lines.itemId: "0",
      Lines.lineType: 0,
      Lines.verticalLinesDownwards: 1,
      Lines.horizontalCharacterRight: 1,
    },
    {
      Lines.id: "1",
      Lines.itemId: "0",
      Lines.lineType: 1,
      Lines.verticalLinesDownwards: 1,
      Lines.horizontalCharacterRight: 1,
    },
    {
      Lines.id: "2",
      Lines.itemId: null,
      Lines.lineType: 0,
      Lines.verticalLinesDownwards: 1,
      Lines.horizontalCharacterRight: -3,
    },
    {
      Lines.id: "3",
      Lines.itemId: null,
      Lines.lineType: 0,
      Lines.verticalLinesDownwards: 1,
      Lines.horizontalCharacterRight: 8,
    },
    {
      Lines.id: "4",
      Lines.itemId: null,
      Lines.lineType: 0,
      Lines.verticalLinesDownwards: null,
      Lines.horizontalCharacterRight: null,
    },
  ];

  List<Map<String,dynamic>> listOfBlocks = [
    {
      Blocks.id: "0",
      Blocks.lineId: "0",
      Blocks.dataType: 2,
      Blocks.maxLength: 12,
      Blocks.isRequired: 1,
      Blocks.key: "Item",
    },
    {
      Blocks.id: "1",
      Blocks.lineId: "0",
      Blocks.dataType: 0,
      Blocks.maxLength: 10,
      Blocks.isRequired: 0,
      Blocks.key: null,
    },
    {
      Blocks.id: "2",
      Blocks.lineId: "0",
      Blocks.dataType: 2,
      Blocks.maxLength: 8,
      Blocks.isRequired: 1,
      Blocks.key: "Item Total Price",
    },
    {
      Blocks.id: "3",
      Blocks.lineId: "0",
      Blocks.dataType: 1,
      Blocks.maxLength: 1,
      Blocks.isRequired: 1,
      Blocks.key: "Tax",
    },
    {
      Blocks.id: "4",
      Blocks.lineId: "2",
      Blocks.dataType: 1,
      Blocks.maxLength: 7,
      Blocks.isRequired: 1,
      Blocks.key: "subtotal",
    },
    {
      Blocks.id: "5",
      Blocks.lineId: "2",
      Blocks.dataType: 3,
      Blocks.maxLength: 10,
      Blocks.isRequired: 1,
      Blocks.key: null,
    },
    {
      Blocks.id: "6",
      Blocks.lineId: "3",
      Blocks.dataType: 1,
      Blocks.maxLength: 3,
      Blocks.isRequired: 1,
      Blocks.key: "hst",
    },
    {
      Blocks.id: "7",
      Blocks.lineId: "3",
      Blocks.dataType: 4,
      Blocks.maxLength: 9,
      Blocks.isRequired: 1,
      Blocks.key: null,
    },
    {
      Blocks.id: "8",
      Blocks.lineId: "3",
      Blocks.dataType: 3,
      Blocks.maxLength: 10,
      Blocks.isRequired: 1,
      Blocks.key: null,
    },
    {
      Blocks.id: "9",
      Blocks.lineId: "4",
      Blocks.dataType: 1,
      Blocks.maxLength: 5,
      Blocks.isRequired: 1,
      Blocks.key: "total",
    },
    {
      Blocks.id: "10",
      Blocks.lineId: "4",
      Blocks.dataType: 3,
      Blocks.maxLength: 10,
      Blocks.isRequired: 1,
      Blocks.key: null,
    },
  ];

  Map<String,dynamic> subTotal = {
    SubTotal.id: "0",
    SubTotal.formatId: "0",
    SubTotal.listOfLineIds: jsonEncode(["2"]),
    SubTotal.startingText: "subtotal",
    SubTotal.possibleLines: 1,
    SubTotal.verticalLinesUpwards: 2,
  };

  Map<String,dynamic> tax = {
    Tax.id: "0",
    Tax.formatId: "0",
    Tax.listOfLineIds: jsonEncode(["3"]),
    Tax.startingText: "gst",
    Tax.possibleLines: 1,
    Tax.verticalLinesUpwards: 2,
  };


  Map<String,dynamic> total = {
    Total.id: "0",
    Total.formatId: "0",
    Total.listOfLineIds: jsonEncode(["4"]),
    Total.startingText: "total",
    Total.possibleLines: 1,
    Total.verticalLinesUpwards: null,
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
      await deleteAllTables();

      await Formats.instance.insert(formatRow);

      for (var itemRow in listOfItems) {
        await Items.instance.insert(itemRow);
      }
      for (var lineRow in listOfLines) {
        await Lines.instance.insert(lineRow);
      }
      for (var blockRow in listOfBlocks) {
        await Blocks.instance.insert(blockRow);
      }

      await SubTotal.instance.insert(subTotal);
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
