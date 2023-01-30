import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:receipt_format_maker/Tables/blocks.dart';
import 'package:receipt_format_maker/Tables/format.dart';
import 'package:receipt_format_maker/Tables/items.dart';
import 'package:receipt_format_maker/Tables/lines.dart';
import 'package:receipt_format_maker/Tables/sub_total.dart';
import 'package:receipt_format_maker/Tables/tax.dart';
import 'package:receipt_format_maker/Tables/total.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

String path = "";

Future onCreate(Database db, int version) async {
  await Formats.instance.onCreate(db, version);
  await Items.instance.onCreate(db, version);
  await Lines.instance.onCreate(db, version);
  await Blocks.instance.onCreate(db, version);
  await Tax.instance.onCreate(db, version);
  await SubTotal.instance.onCreate(db, version);
  await Total.instance.onCreate(db, version);
}

deleteAllTables() async{
  await Formats.instance.deleteall();
  await Items.instance.deleteall();
  await Lines.instance.deleteall();
  await Blocks.instance.deleteall();
  await Tax.instance.deleteall();
  await SubTotal.instance.deleteall();
  await Total.instance.deleteall();
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