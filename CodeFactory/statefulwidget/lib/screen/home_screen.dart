import 'package:flutter/material.dart';

// stateful 위젯
class HomeScreen extends StatefulWidget {
  final Color color;

  const HomeScreen({
    required this.color,
    Key? key,
}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen>{
  // 하지만 stateful에서는 파라미터로 받아서 변수선언하면 안 된다.
  // 그렇게 하면, 바뀌지 않는다.

  // state는 무조건 stateful위젯과 세트로간다.
  // 그래서 이 위의 위젯의 값을 가져올 수 있다.
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      color: widget.color,
    );
  }
}


// 그리고 사실은, 컨텍스트액션을 통해 한 번에
// stateless 를 stateful위젯으로 바꿀 수 있다.

// stateless 위젯
class _HomeScreen extends StatelessWidget {
  // stareless에서는 이렇게 파라미터로 받아온 것을 내부에 변수로 선언해서,
  // 직접 사용하면 된다.
  final Color color;

  const _HomeScreen({
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      color: color,
    );
  }
}