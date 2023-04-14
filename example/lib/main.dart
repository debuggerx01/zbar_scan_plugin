import 'package:flutter/material.dart';
import 'package:zbar_scan_plugin/zbar_scan_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<CodeInfo> codes;

  @override
  void initState() {
    var stopwatch = Stopwatch()..start();
    codes = scan('/home/debuggerx/Desktop/2.png');
    print(stopwatch.elapsedMilliseconds);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 25);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Packages'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: codes
                  .map(
                    (code) => Text(
                      '${code.content} ${code.points.map((point) => '(${point.x},${point.y})').join(' ')}',
                      style: textStyle,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
