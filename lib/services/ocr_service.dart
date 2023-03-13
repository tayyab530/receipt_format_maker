import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:provider/provider.dart';
import 'package:receipt_format_maker/Models/block_model.dart';
import 'package:receipt_format_maker/Tables/receipts_elements.dart';

class PrvOcrService with ChangeNotifier {
  final TextRecognizer _recognizer = GoogleMlKit.vision.textRecognizer();
  late RecognizedText _extractedText;
  static const blockKey = "Block";
  static const lineKey = "Line";
  static const elementKey = "Element";

  List<TextElement> listOfTextElements = [];

  Map<List<String>, List<bool>> _linesMap = {};
  Map<String, List<dynamic>> _segregatedData = {};

  Point<int> currentCursorPointVertically = Point(0, 0);
  Point<int> currentCursorPointHorizontally = Point(0, 0);

  Future<Map<List<String>, List<bool>>> getText(InputImage image) async {
    try {
      _extractedText = await _recognizer.processImage(image);
      int i = 0;
      for (TextBlock block in _extractedText.blocks) {
        // block.boundingBox.;
        for (TextLine line in block.lines) {
          _linesMap.addAll({
            [line.text, i.toString()]: [false, false]
          });
          i++;
        }
      }

      return _linesMap;
    } catch (e) {
      return Future.value({});
    }
  }

  List<TextElement> get getElements => listOfTextElements;

  saveElementsToDB(String formatId) async {
    try {
      int i = 1;

      var elementsInstance = Elements.instance;

      for (var element in listOfTextElements) {
        var topLeft = element.cornerPoints[0];
        var topRight = element.cornerPoints[1];
        var bottomRight = element.cornerPoints[2];
        var bottomLeft = element.cornerPoints[3];

        var row = {
          Elements.formatId: formatId,
          Elements.elementId: i.toString(),
          Elements.text: element.text,
          Elements.topLeftCoordinate: topLeft.toString(),
          Elements.topLeftX: topLeft.x,
          Elements.topLeftY: topLeft.y,
          Elements.topRightCoordinate: topRight.toString(),
          Elements.topRightX: topRight.x,
          Elements.topRightY: topRight.y,
          Elements.bottomRightCoordinate: bottomRight.toString(),
          Elements.bottomRightX: bottomRight.x,
          Elements.bottomRightY: bottomRight.y,
          Elements.bottomLeftCoordinate: bottomLeft.toString(),
          Elements.bottomLeftX: bottomLeft.x,
          Elements.bottomLeftY: bottomLeft.y,
        };

        await elementsInstance.insert(row);
        i++;
      }
    } catch (e) {
      print("Saving failed!!!: \n${e.toString()}");
    }
  }

  Future<List<TextElement>> scan(InputImage image) async {
    try {
      _extractedText = await _recognizer.processImage(image);

      var blocks = _extractedText.blocks.toList();

      var elements = <TextElement>[];

      for (var block in blocks) {
        for (var line in block.lines) {
          elements.addAll(line.elements.toList());
        }
      }

      listOfTextElements = elements;

      return elements;
    } catch (e) {
      print(e.toString());
      return Future.value([]);
    }
  }

  Map<String, dynamic> getDataByType() {
    List<TextBlock> listOfBlocks = _extractedText.blocks;
    List<List<TextLine>> listOfLines =
        listOfBlocks.map((e) => e.lines).toList();
    List<List<List<TextElement>>> listOfElements = listOfLines
        .map((lol) => lol.map((l) => l.elements.toList()).toList())
        .toList();

    return {
      blockKey: listOfBlocks,
      lineKey: listOfLines,
      elementKey: listOfElements
    };
  }

  static double getCharacterWidth(BlockData blockData) {
    double charWidth = blockData.maxLength / blockData.maxLength;
    return charWidth;
  }

  static double calculateTotalWidthElement(double maxLength, double charWidth) {
    double elemWidth = maxLength * charWidth;
    return elemWidth;
  }

  void updateVerticalPointer(Point<int> newPoint) =>
      currentCursorPointVertically = newPoint;

  void updateHorizontalPointer(Point<int> newPoint) =>
      currentCursorPointHorizontally = newPoint;

  traverseElementsHorizontally(bool isRequired, BlockData blockData) {
    var elems = findElementsByCursorPointHorizontally(blockData);

    if (blockData.isInitialBlock()) {
      if (elems.isNotEmpty) {
        updateHorizontalPointer(elems.first.cornerPoints.first);
      }
    }
    print(elems.toString());
  }

  bool hasCursorReachedGivenTag(String tag) {
    if(currentCursorPointVertically.y > maxDepthOfY() || tag.isEmpty) {
      return true;
    }
    var tags = tag.split(",");
    var tagElement = tags
        .map((t) {
          var listOfTextElems =
              getElements.where((element) => element.text.toLowerCase() == t.toLowerCase()).toList();
          if (listOfTextElems.isNotEmpty) {
            return listOfTextElems.first;
          } else {
            null;
          }
        })
        .toList()
        .where((element) => element != null)
        .toList();
    return currentCursorPointVertically.compareWithinRangeVertically(
        tagElement.first!.cornerPoints.first,
        thresholdForX: 1000);
  }

  List<TextElement> findElementsByCursorPointHorizontally(BlockData blockData) {
    var selectedElements = getElements.where((element) {
      return element.cornerPoints.first
          .compareWithinRangeHorizontally(currentCursorPointHorizontally);
    }).toList();

    if (selectedElements.isNotEmpty) {
      selectedElements.sort(
        (a, b) => b.cornerPoints.first.y.compareTo(a.cornerPoints.first.x),
      );
      updateHorizontalPointer(Point(currentCursorPointHorizontally.x,
          selectedElements.first.cornerPoints.first.y));
      return selectedElements;
    } else {
      return <TextElement>[];
    }
  }

  int maxDepthOfY() {
    getElements
        .sort((a, b) => a.cornerPoints.last.y.compareTo(b.cornerPoints.last.y));

    return getElements.last.cornerPoints.last.y;
  }

  clearData() {
    _linesMap = {};
    _segregatedData = {};
  }
}

extension TextElementsAdditionals on Point<int> {
  bool compareWithinRangeVertically(Point<int> referencePoint,
      {double thresholdForX = 50, double thresholdForY = 100}) {
    // giving 10 pixels threshold each axis
    var condition1ForX1 = x;
    var condition1ForX = x > referencePoint.x - thresholdForX;
    var condition2ForX = x < referencePoint.x + thresholdForX;
    var condition1ForY = y > referencePoint.y;
    var condition2ForY = y < referencePoint.y + thresholdForY;

    if (condition1ForX && condition2ForX) {
      if (condition1ForY && condition2ForY) {
        return true;
      }
    }
    return false;
  }

  addThresholdToY({double? threshold}) {}

  bool compareWithinRangeHorizontally(Point<int> referencePoint,
      {double thresholdForX = 10, double thresholdForY = 10}) {
    // giving 10 pixels threshold each axis
    var condition1ForX1 = x;
    var condition1ForX = x > referencePoint.x - thresholdForX;
    var condition2ForX = x < referencePoint.x + thresholdForX;
    var condition1ForY = y > referencePoint.y;
    var condition2ForY = y < referencePoint.y + thresholdForY;

    if (condition1ForX && condition2ForX) {
      if (condition1ForY && condition2ForY) {
        return true;
      }
    }
    return false;
  }

  addThresholdToX({double? threshold}) {}
}

enum TextType {
  block,
  line,
  element,
}

enum SearchTrack {
  vertical,
  horizontal,
}

// idd int
// table: text = TOTAL,
// top-left =Point(374, 1378),
// top-left-x =374
// top-left-y =1378
// top-right = Point(496, 1378),
// bottom-left = Point(374, 1428)
// bottom-right = Point(496, 1428)
