import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'listen.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  final StreamController<int> streamController = StreamController<int>();
  @override
  int sayi = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COUNTER PAGE"),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              child: StreamBuilder(
                stream: streamController.stream,
                builder: (context, snapshot) {
                  if (sayi == -4) {
                    return Text("-4 den fazla aşağıya gidilmez ${sayi}");
                  }
                  return Text(sayi.toString());
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (sayi == -4) {
                    sayi.isNaN;
                  }
                  streamController.sink.add(sayi++);
                  print(sayi.toString());
                },
                child: Text("INCREASE")),
            ElevatedButton(
                onPressed: () {
                  streamController.sink.add(sayi--);
                  stop();
                },
                child: Text("EKSİ")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Stream_detail(),
                      ));
                },
                child: Text("STREAM DETAİLS"))
          ],
        ),
      ),
    );
  }

  void stop() {
    if (sayi == -4) {
      streamController.close();
    }
  }
}
