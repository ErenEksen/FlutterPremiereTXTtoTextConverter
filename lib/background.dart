// ignore_for_file: curly_braces_in_flow_control_structures

import "dart:io";
import 'dart:core';

//Entry point
Future<bool> convertText(String path, bool graph) async {
  String content = await readContent(path);
  String convertedText = "";
  if (graph)
    convertedText = premiereGraphTxtConvert(content);
  else
    convertedText = premiereSubTxtConvert(content);
    
  if (convertedText == 'Empty') return false;
  writeContent(path, convertedText);
  return true;
}

// Reads the content of the file at the specified path
Future<String> readContent(String path) async {
  File file = File(path);
  final content = await file.readAsString();
  return content;
}

// Writes the provided newText to the file at the specified path
void writeContent(String path, String newText) {
  File file = File(path);
  file.writeAsString(newText.replaceFirst('\n', ''));
}

// Checks if the given character is a digit
bool isDigit(String char) {
  final charCode = char.codeUnitAt(0);
  return charCode >= '0'.codeUnitAt(0) && charCode <= '9'.codeUnitAt(0);
}

// Converts text for graph format
String premiereGraphTxtConvert(String text) {
  List<String> spllitedText = text.split("\n");
  List<String> newText = [''];
  bool isSomethingChanged = false;
  int i = 1;
  while (i < spllitedText.length) {
    if (spllitedText[i].length > 1 &&
        spllitedText[i][0] == 'V' &&
        isDigit(spllitedText[i][1])) {
      isSomethingChanged = true;
      i++;
      if (newText.last != spllitedText[i]) {
        while (spllitedText[i] != '' && spllitedText[i] != ' ') {
          newText.add(spllitedText[i]);
          if (i + 1 < spllitedText.length)
            i++;
          else
            break;
        }
      }
    } else {
      i++;
    }
  }
  if (isSomethingChanged) {
    return newText.join('\n');
  } else {
    return 'Empty';
  }
}

// Converts text for subtitle format
String premiereSubTxtConvert(String text) {
  List<String> spllitedText = text.split("\n");
  List<String> newText = [''];
  bool isSomethingChanged = false;
  int i = 0;
  while (i < spllitedText.length) {
    if (spllitedText[i].length > 2 &&
        isDigit(spllitedText[i][0]) &&
        isDigit(spllitedText[i][1]) &&
        spllitedText[i][2] == ':') {
      isSomethingChanged = true;
      i++;
      if (newText.last != spllitedText[i]) {
        while (spllitedText[i] != '' && spllitedText[i] != ' ') {
          newText.add(spllitedText[i]);
          if (i + 1 < spllitedText.length)
            i++;
          else
            break;
        }
      }
    } else {
      i++;
    }
  }
  if (isSomethingChanged) {
    return newText.join('\n');
  } else {
    return 'Empty';
  }
}
