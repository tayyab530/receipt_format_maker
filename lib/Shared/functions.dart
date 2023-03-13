import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:receipt_format_maker/Tables/blocks.dart';
import 'package:receipt_format_maker/Tables/format.dart';
import 'package:receipt_format_maker/Tables/receipts_elements.dart';
import 'package:receipt_format_maker/Tables/row_sequence.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

String path = "";

Future onCreate(Database db, int version) async {
  await Formats.instance.onCreate(db, version);
  await RowSequence.instance.onCreate(db, version);
  await Blocks.instance.onCreate(db, version);
  await Elements.instance.onCreate(db, version);
}

deleteAllDataFromTables() async{
  await Formats.instance.deleteall();
  await RowSequence.instance.deleteall();
  await Blocks.instance.deleteall();
  await Elements.instance.deleteall();
}

createDB() async {
  try {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    path = join(documentsDirectory.path, "DB.db");
    // path = join(documentsDirectory.path, "DB$_version.db");

    return await openDatabase(path, version: 1, onCreate: onCreate);
  } catch (e) {
    debugPrint(e.toString());
  }
}

showError(BuildContext ctx,String message){
  var snackBar = SnackBar(content: Row(
    children: [
      const Icon(Icons.error),
      const SizedBox(width: 10,),
      Text(message),
    ],
  ));
  ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
  var _ = ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
}

showInfo(BuildContext ctx,String message){
  var snackBar = SnackBar(content: Row(
    children: [
      const Icon(Icons.info),
      const SizedBox(width: 10,),
      Text(message),
    ],
  ));

  ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
  var _ = ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
}

showSuccess(BuildContext ctx,String message){
  try{
    var snackBar = SnackBar(content: Row(
      children: [
        const Icon(Icons.done),
        const SizedBox(width: 10,),
        Text(message),
      ],
    ));
    ScaffoldMessenger.of(ctx).hideCurrentSnackBar();
    var _ = ScaffoldMessenger.of(ctx).showSnackBar(snackBar);

  }
  catch(e){
    print(e.toString());
  }
}

showSyncingSB(BuildContext ctx,String message,{int secs = 5}){
  try {
    var snackBar = SnackBar(
      duration: Duration(
        seconds: secs,
      ),
      content: Row(
        children: <Widget>[
          new CircularProgressIndicator(
            backgroundColor: Colors.deepOrange[200],
            color: Colors.grey[300],
          ),
          const SizedBox(width: 10),
          new Text(message)
        ],
      ),
    );

    ScaffoldMessenger.of(ctx).showSnackBar(snackBar);

  } catch (e) {
    print(e.toString());
  }
}