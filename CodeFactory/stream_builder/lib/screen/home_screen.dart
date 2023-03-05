import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16.0,
    );

    return Scaffold(
      // 여기에 snapshot에 들어오는 <>제네릭을 넣을 수 있다.
      // 굳이 안 넣어줘도 자동으로 타입이 지정되긴 한다.
      //
      // 이 스트림빌더의 엄청난 장점은,
      // 우리가 스트림을 열어주면 닫아줘야하는데,
      // 이 스트림빌더는 알아서 스트림을 닫아줘서 신경 쓸 필요가 없다.
      //
      // 지금은 이게 잘 안 와닿을 수가 있어요.
      // 나중에 네트워크 요청을 배우고 그러면 지금 이게 얼마나 유용한지 깨달을 수 있을겁니다.
      body: StreamBuilder<int>(
        stream: streamNumbers(),
        builder: (context, AsyncSnapshot<int> snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'StreamBuilder',
                style: textStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
              ),
              Text(
                'ConState : ${snapshot.connectionState}',
                style: textStyle,
              ),
              Text(
                'Data : ${snapshot.data}',
              ),
              Text(
                'Error : ${snapshot.error}',
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text('setState'),
              ),
            ],
          );
        },
      ),
    );
  }

  Stream<int> streamNumbers() async* {
    for (int i = 0; i < 10; i++) {
      if (i == 5) {
        throw Exception('i = 5');
      }

      await Future.delayed((Duration(seconds: 1)));

      yield i;
    }
  }
}
