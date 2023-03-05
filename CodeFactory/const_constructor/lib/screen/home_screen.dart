import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 지금까지 사용한 단축키 단축어 다 외우셔야 됩니다. 그리고 저정도 속도가 나올 때 까지 연습하셔야돼요.
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 우리가 빌드타임의 모든 값을 알 수 있을 때 const를 쓸 수 있다.
            // const를 쓰자마자 노란색 밑줄이 사라진다. const를 써달라는 거다. 왜 그럴까?
            // const를 쓰면 const는 빌드 실행 안된다.
            // const로 만들 면 단 한번만 그려놓으면, 나중에 빌드가 실행됬을 때 그려놓은걸 그대로 사용한다.
            // 그러니 굉장히 효율적인거다. 굳이 const는 다시 빌드하지 않아도되니까.
            // 그래서 우리가 const를 쓸 수 있는 상황이면 왠만하면 const를 쓰는겁니다.

            // 제가 강의할 때는 const가 강의 하는 데 조금 불편하기 때문에 전 안 쓸겁니다.

            const TestWiget(label: 'test1'),
            TestWiget(label: 'test2'),

            // 이런 버튼 위젯에는 const를 못 쓴다.
            // 빌드 할 때의 값을 알지 못하기 때문이다. 함수에서 뭐가 실행될지 알고..
            ElevatedButton(onPressed: (){
              setState(() {

              });
            }, child: const Text('빌드!'))
          ],
        ),
      ),
    );
  }
}

class TestWiget extends StatelessWidget {
  final String label;

  const TestWiget({required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('$label build 실행!');
    
    return Container(
      child: Text(
        label,
      ),
    );
  }
}
