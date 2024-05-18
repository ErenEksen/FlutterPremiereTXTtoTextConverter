// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:premiere_txt_to_text_converter/background.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Premiere Txt to Text Converter',
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<bool> isSelected = [true, false];
  String? path;
  String appName = "";
  Color appNameColor = Colors.grey;
  final nothingSelectedTextController = TextEditingController();
  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'], // Specify the allowed file extensions
    );

    if (result != null) {
      setState(() {
        path = result.files.single.path;
        appName = "$path".split('/').last;
        appNameColor = Colors.yellow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        title:  Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
           child: const Text('Premiere\nConverter', style: TextStyle(fontSize: 20),)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),
            child: ToggleButtons(
              isSelected: isSelected,
              children: const [
                Text('Graphic', style: TextStyle(fontSize: 15)),
                Text('Subtitle', style: TextStyle(fontSize: 15))
              ],
              onPressed: (index) {
                setState(() {
                  if (isSelected[index] == true)
                    return;
                  else {
                    isSelected[index] = true;
                    isSelected[(index - 1).abs()] = false;
                  }
                });
              },
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Select the\nSubtitle file'),
                const SizedBox(height: 1.0, width: 10),
                ElevatedButton(
                    onPressed: () {
                      _pickFile();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text('Add Files',
                          style: TextStyle(color: Colors.white)),
                    )),
              ],
            ),
            const SizedBox(height: 38.0),
            Align( alignment: Alignment.bottomLeft, heightFactor: 1, child: Text(path != null ? appName : "        Nothing is selected",
                style: TextStyle(color: appNameColor))),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          bool status = await convertText("$path", isSelected[0]);
          setState(() {
            if (status)
              appNameColor = Colors.green;
            else
              appNameColor = Colors.red;
          });
        },
        child: const Text('Start'),
      ),
    );
  }
}
