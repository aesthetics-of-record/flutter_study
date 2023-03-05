import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Color color;

  HomeScreen({
    required this.color,
    Key? key,
  }) : super(key: key) {
    print('Wiget Constructor 실행!'); // 이렇게 constructor 안에도 body{} 를 넣을 수 있다.
    // 이렇게 되면, 컨스트럭터가 생성이 되지마자 무언가를 실행 할 수 있다.
    // 대신 이렇게 되면, const를 지워줘야한다.
  }

  @override
  State<HomeScreen> createState() {
    print('createState 실행!');
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int number = 0;

  // 그 다음에 저희가 배웠던 함수들은 다 State안에 있던 함수에요.
  // initState는 자동완성이 된다. 왜냐면 State라는 클래스 안에 실제로 이 함수가 존재하기 때문이에요.
  @override
  void initState() {
    super
        .initState(); // 이렇게 initState()를 오퍼라이드 할 때는 이렇게 super.initState()를 불러줘야 한다.

    print('initState 실행!');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    print('didChangeDependencies 실행!');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate 실행!');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose 실행!');
  }

  @override // 여기서 covariant라는 키워드가 새로나왔는데, 신경쓰실 필요가 없다.
  // 이거는 파라미터의 타입을 어떤 타입으로 지정을 했을 때, 상속된 타입으로 오버라이드 할 떄 이걸 쓰는데, 신경 안쓰셔도 됩니다.
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget 실행!');
  }

  @override
  Widget build(BuildContext context) {
    print('build 실행!');

    return GestureDetector(
      onTap: (){
        setState(() {
          number ++;
        });
      },
      child: Container(
        width: 50.0,
        height: 50.0,
        color: widget.color,
        child: Center(
          child: Text(
            number.toString(),
          ),
        ),
      ),
    );
  }
}
