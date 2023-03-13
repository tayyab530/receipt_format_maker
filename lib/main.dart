import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_format_maker/screens/home.dart';
import 'package:receipt_format_maker/services/image_picker_service.dart';
import 'package:receipt_format_maker/services/ocr_service.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ListenableProvider(
            create: (context) => PrvOcrService(),
          ),
          ListenableProvider(
            create: (context) => ImagePickerService(),
          ),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
