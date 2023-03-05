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
      // 이 퓨쳐빌더가 캐싱이 되어있어, setState를 통해 재빌드 해도, 기존데이터를 기억해둔다.
      //
      // 이 캐싱이라는 장점 때문에, 실제로 로딩중인 상황임에도, 기존데이터를 보여줘서
      // 빠르다는 착각을 줄 수가 있다. 그럴 때 활용하는 것이 유리하다.
      //
      body: FutureBuilder(
        future: getNumber(),
        // 우리가 setState를 하지 않고서도, snapshot과 관련된 어떤 값이 바뀌어도
        // 다시 빌더를 통해 빌드가 됩니다.
        builder: (context, snapshot) {
          // 저번에 이렇게 밑에처럼 썼는데, 좋은 행동은 아니다. 앱이 굉장히 느려보인다.
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(child: CircularProgressIndicator());
          // }
          //
          // 이렇게 밑에처럼, 캐싱을 이용해 처음에 한 번만 실행해주는 것이 좋다.
          // if (!snapshot.hasData) {
          //   return Center(child: CircularProgressIndicator());
          // }
          //
          // 아니면 정 로딩을 매번 보여주고 싶으면, 원래 화면위에 로딩을 띄우는 게
          // 훨씬 더 빨라보인다.

          if (snapshot.hasData) {
            // 데이터가 있을 때 위젯 렌더링
          }

          if (snapshot.hasError) {
            // 에러가 났을 때 위젯 렌더링
          }

          // 로딩중일때 위젯 렌더링

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'FutureBuilder',
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

  Future<int> getNumber() async {
    await Future.delayed(Duration(seconds: 3));

    final random = Random();

    // throw Exception('에러가 발생했습니다.');

    return random.nextInt(100);
  }
}
