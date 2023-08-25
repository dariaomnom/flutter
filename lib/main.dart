/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Picker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  final picker = ImagePicker();
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void dispose() {
    textController1.dispose();
    textController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Demo'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: textController1,
              decoration: InputDecoration(
                labelText: 'Value 1',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: textController2,
              decoration: InputDecoration(
                labelText: 'Value 2',
              ),
            ),
          ),
          SizedBox(height: 20),
          _image == null
              ? Text('No image selected.')
              : Image.file(_image, width: 200, height: 200),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: getImage,
            child: Text('Choose Image'),
          ),
        ],
      ),
    );
  }
}
*/


import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Analyzer',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
      //   // useMaterial3: true,
      // ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
      ),
      home: const MyHomePage(title: 'Analyzer home page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  void delImage(File? image) {
    // image = null;
    // final imageTemp = File(image.path);
    setState(() => this.image = null);
  }



  final myControllerStart = TextEditingController();
  @override
  void disposeStart() {
    myControllerStart.dispose();
    super.dispose();
  }
  final myControllerEnd = TextEditingController();
  @override
  void disposeEnd() {
    myControllerEnd.dispose();
    super.dispose();
  }
  var startValue = '';
  var endValue = '';
  void printVal(someValue) {
    print(someValue);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // title: Text(widget.title),
        title: Text('Analyzer'),
        centerTitle: true,
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(16),
      //   child: TextField(
      //     controller: myController,
      //   ),
      // ),

        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.0),
                  // border: InputBorder.try,
                  labelText: 'The first value',
                  hintText: 'Enter the start value',
                  // child: Text('First value'),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  // FilteringTextInputFormatter.allow(RegExp(r"^(0|[1-9]\d*)([.,]\d+)?")),
                  // FilteringTextInputFormatter.allow(RegExp(r'^[-+]?[0-9]*[.,]?[0-9]+(?:[eE][-+]?[0-9]+)?$')),
                  // FilteringTextInputFormatter.allow(RegExp(r'[0-9]+\.[0-9]+')),
                  // FilteringTextInputFormatter.singleLineFormatter,
                  // WhitelistingTextInputFormatter(RegExp(r"[0-9]+\.[0-9]+")),
                ],
                onChanged: (newVal) {
                  startValue = newVal;
                  // printVal(startValue);
                },
                controller: myControllerStart,
              ),
              TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.0),
                  // border: InputBorder.try,
                  labelText: 'The second value',
                  hintText: 'Enter the end value',
                  border: OutlineInputBorder(),
                  // child: Text('First value'),
                ),
                keyboardType: TextInputType.number,
                // inputFormatters: [
                //   FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+\.[0-9]+')),
                //   FilteringTextInputFormatter.singleLineFormatter,
                //   // WhitelistingTextInputFormatter(RegExp(r"^[0-9]+\.[0-9]+")),
                // ],
                onChanged: (newVal) {
                  endValue = newVal;
                  // printVal(endValue);
                },
                controller: myControllerEnd,
              ),

              MaterialButton(
                color: Colors.green,
                child: const Text('Pick image from gallery'),
                onPressed: () {
                  pickImage();
                },
              ),
              MaterialButton(
                color: Colors.green,
                child: const Text('Pick image from camera'),
                onPressed: () {
                  pickImageC();
                },
              ),
              SizedBox(height: 100, child: image != null ? Image.file(image!): Text("No image selected"),),
              // image != null ? Image.file(image!): Text("No image selected"),
              MaterialButton(
                color: Colors.red,
                child: const Icon(Icons.delete),
                onPressed: () {
                  // image = null;
                  delImage(image);
                },
              ),

            ],
          ),
        ),



      // тестирую паддинг
        /*
      body: Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // TextField(controller: myController,),
            Padding(
              padding: const EdgeInsets.all(30),
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // стартовое значение без форматированного ввода
                  // TextField(
                  //   decoration: InputDecoration(
                  //     // border: InputBorder.try,
                  //     labelText: 'The first value',
                  //     hintText: 'Enter the start value',
                  //     // child: Text('First value'),
                  //   ),
                  //   controller: myControllerStart,
                  // ),
                  // стартовое значение без форматированного ввода
                  // стартовое с форматом
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20.0),
                      // border: InputBorder.try,
                      labelText: 'The first value',
                      hintText: 'Enter the start value',
                      // child: Text('First value'),
                      border: OutlineInputBorder(),
                      // contentPadding: EdgeInsets.symmetric(vertical: 40),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      // FilteringTextInputFormatter.allow(RegExp(r"^(0|[1-9]\d*)([.,]\d+)?")),
                      // FilteringTextInputFormatter.allow(RegExp(r'^[-+]?[0-9]*[.,]?[0-9]+(?:[eE][-+]?[0-9]+)?$')),
                      // FilteringTextInputFormatter.allow(RegExp(r'[0-9]+\.[0-9]+')),
                      // FilteringTextInputFormatter.singleLineFormatter,
                      // WhitelistingTextInputFormatter(RegExp(r"[0-9]+\.[0-9]+")),
                    ],
                    onChanged: (newVal) {
                      startValue = newVal;
                      // printVal(startValue);
                    },
                    controller: myControllerStart,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20.0),
                      // border: InputBorder.try,
                      labelText: 'The second value',
                      hintText: 'Enter the end value',
                      border: OutlineInputBorder(),
                      // child: Text('First value'),
                    ),
                    keyboardType: TextInputType.number,
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+\.[0-9]+')),
                    //   FilteringTextInputFormatter.singleLineFormatter,
                    //   // WhitelistingTextInputFormatter(RegExp(r"^[0-9]+\.[0-9]+")),
                    // ],
                    onChanged: (newVal) {
                      endValue = newVal;
                      // printVal(endValue);
                      },
                    controller: myControllerEnd,
                  ),



                ],
              ),
              // child: TextField(
              //   decoration: InputDecoration(
              //     // border: InputBorder.try,
              //     labelText: 'The first value',
              //     hintText: 'Enter the start value',
              //     // child: Text('First value'),
              //   ),
              //   controller: myController,
              // ),
            ),
            MaterialButton(
              color: Colors.green,
              child: const Text('Pick image from gallery'),
              onPressed: () {
                pickImage();
              },
            ),
            MaterialButton(
              color: Colors.green,
              child: const Text('Pick image from camera'),
              onPressed: () {
                pickImageC();
              },
            ),
            SizedBox(height: 20,),
            image != null ? Image.file(image!): Text("No image selected"),
          ],
        ),
      ),
      */ // ~ тестирую паддинг





      // body: Center(
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Text('First value'),
      //           TextField(
      //             controller: myController,
      //           ),
      //           // floatingActionButton: FloatingActionButton(
      //           //   onPressed: () {
      //           //     showDialog(
      //           //       context: context,
      //           //       builder: (context) {
      //           //         return AlertDialog(
      //           //           content: Text(myController.text),
      //           //         );
      //           //       },
      //           //     );
      //           //   },
      //           //   tooltip: 'Show me the value!',
      //           //   child: const Icon(Icons.text_fields),
      //           // ),
      //           Text('Second value'),
      //           // TextField(
      //           //   controller: myController,
      //           // ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(myControllerStart.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showDialog(
      //       context: context,
      //       builder: (context) {
      //         return AlertDialog(
      //           content: Text('You wrote $endValue'),
      //         );
      //       },
      //     );
      //   },
      // ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headlineMedium,
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


// супер старое, можно не трогать
// void main () => runApp(MyApp());
//
// class MyApp extends StatefulWidget {
//   // const Home({Key key}) : super(key: key);
//   const MyApp({super.key, required this.title});
//   final String title;
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       appBar: AppBar(
//         title: Text('Analyzer'),
//         centerTitle: true,
//       ),
//       body: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text('First value'),
//                 Text('Second value'),
//               ],
//             )
//           ],
//       ),
//     );
//   }
// }


// типа работает но без состояний
// void main () => runApp(MyApp());
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey),
//       ),
//       home: Scaffold(
//           appBar: AppBar(
//             title: Text('dariaomnom\'s app', style: TextStyle(color: Colors.black)),
//             centerTitle: true,
//           ),
//           body: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Text('First value'),
//                   Text('Second value'),
//                 ],
//               )
//             ],
//           ),
//           // floatingActionButton: FloatingActionButton(
//           //   child: Text('Push'),
//           //   onPressed: () {
//           //     print('Clicked');
//           //   },
//           // )
//
//         //child: Text('Push'),
//       ),
//     );
//   }
// }
// типа работает но без состояний

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       appBar: AppBar(
//         title: Text('Analyzer'),
//         centerTitle: true,
//       ),
//       body: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text('First value'),
//                 Text('Second value'),
//               ],
//             )
//           ],
//       ),
//     );
//
//   }
// }


// void main() => runApp(const MaterialApp(
//   // theme: ThemeData(
//   //   colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
//   // ),
//   home: Home(),
// ));

// void main () => runApp(Home());
//
// class Home extends StatefulWidget {
//   // const Home({Key key}) : super(key: key);
//   const Home({super.key});
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       appBar: AppBar(
//         title: Text('Analyzer'),
//         centerTitle: true,
//       ),
//       body: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text('First value'),
//                 Text('Second value'),
//               ],
//             )
//           ],
//       ),
//     );
//   }
// }



// body: Padding(
//   padding: const EdgeInsets.all(30),
//   child: Column(
//     children: [
//       TextField(
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.all(20.0),
//           // border: InputBorder.try,
//           labelText: 'The first value',
//           hintText: 'Enter the start value',
//           // child: Text('First value'),
//           border: OutlineInputBorder(),
//         ),
//         keyboardType: TextInputType.number,
//         inputFormatters: [
//           // FilteringTextInputFormatter.allow(RegExp(r"^(0|[1-9]\d*)([.,]\d+)?")),
//           // FilteringTextInputFormatter.allow(RegExp(r'^[-+]?[0-9]*[.,]?[0-9]+(?:[eE][-+]?[0-9]+)?$')),
//           // FilteringTextInputFormatter.allow(RegExp(r'[0-9]+\.[0-9]+')),
//           // FilteringTextInputFormatter.singleLineFormatter,
//           // WhitelistingTextInputFormatter(RegExp(r"[0-9]+\.[0-9]+")),
//         ],
//         onChanged: (newVal) {
//           startValue = newVal;
//           // printVal(startValue);
//         },
//         controller: myControllerStart,
//       ),
//       TextField(
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.all(20.0),
//           // border: InputBorder.try,
//           labelText: 'The second value',
//           hintText: 'Enter the end value',
//           border: OutlineInputBorder(),
//           // child: Text('First value'),
//         ),
//         keyboardType: TextInputType.number,
//         // inputFormatters: [
//           //   FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+\.[0-9]+')),
//           //   FilteringTextInputFormatter.singleLineFormatter,
//           //   // WhitelistingTextInputFormatter(RegExp(r"^[0-9]+\.[0-9]+")),
//         // ],
//         onChanged: (newVal) {
//           endValue = newVal;
//           // printVal(endValue);
//         },
//         controller: myControllerEnd,
//       ),
//
//       MaterialButton(
//         color: Colors.green,
//         child: const Text('Pick image from gallery'),
//         onPressed: () {
//           pickImage();
//         },
//       ),
//       MaterialButton(
//         color: Colors.green,
//         child: const Text('Pick image from camera'),
//         onPressed: () {
//           pickImageC();
//         },
//       ),
//       SizedBox(height: 20,),
//       image != null ? Image.file(image!): Text("No image selected"),
//
//     ],
//   ),
// )