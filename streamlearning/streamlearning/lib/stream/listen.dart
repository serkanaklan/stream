import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Stream_detail extends StatefulWidget {
  const Stream_detail({super.key});

  @override
  State<Stream_detail> createState() => _Stream_detailState();
}

class _Stream_detailState extends State<Stream_detail> {
  final StreamController sekoControll = StreamController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  sekoStream().listen((event) {
                    print(event * event * event);
                  });
                },
                child: Text("EVENT CALİSTİRİR")),
            ElevatedButton(
                onPressed: () {
                  sekoControll.stream.listen((event) {
                    print("event numarası : ${event}");
                  });
                },
                child: Text("LİSTEN CALİSTİRİR")),
            ElevatedButton(
              onPressed: () {
                for (var i = 0; i < 30; i++) {
                  sekoControll.stream.listen(
                    (event) {},
                    onDone: () {
                      print("ON DONE ÇALIŞIYOR ");
                    },
                  );
                }
              },
              child: Text("ON DONE CALİSTİRİR"),
            ),
            ElevatedButton(
              onPressed: () {
                for (var i = 0; i < 30; i++) {
                  print(i);
                  if (i == 7) {
                    sekoControll.stream.listen((event) {}, onError: (error) {
                      print(error);
                    });
                  }
                }
                sekoControll.stream.listen((event) {
                  print("ON ERROR ${event}");
                }, onError: (error) {
                  print(error);
                });
              },
              child: Text("ERROR"),
            ),
            ElevatedButton(
              onPressed: () {
                errorlu_booleanli();
              },
              child: Text("ON CANCEL CALİSTİRİR"),
            )
          ],
        ),
      ),
    );
  }

  void voidseko() async {
    for (var a = 0; a < 30; a++) {
      await Future.delayed(Duration(seconds: 1));
      sekoControll.sink.add(a + 2);
    }
  }

  Stream<int> sekoStream() async* {
    for (var i = 0; i < 30; i++) {
      if (i < 24) {
        print("if i < 24");
        sekoControll.close();
      }
      await Future.delayed(Duration(seconds: 1));
      yield i;
    }
  }

  // void errorlu() {
  //   for (var i = 0; i < 30; i++) {
  //     print(i);
  //     if (i == 13) {
  //       sekoControll.addError("İ DEGERİ 13");
  //       sekoControll.close();
  //     }
  //   }
  // }

  void errorlu_booleanli() {
    for (var i = 0; i < 30; i++) {
      print(i);
      if (i == 13) {
        sekoControll.addError("İ DEGERİ 13");
        sekoControll.close();
        sekoControll.stream.listen((event) {
          print("ON ERROR ${event}");
        }, onError: (error) {
          print("error");
          return AlertDialog(
            title: Text("ERROR"),
          );
        }, cancelOnError: true);
      }
    }
  }
}
