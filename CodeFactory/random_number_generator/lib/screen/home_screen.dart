import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_number_generator/component/number_row.dart';
import 'package:random_number_generator/constant/color.dart';
import 'package:random_number_generator/screen/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int maxNumber = 1000;

  List<int> randomNumbers = [
    123,
    456,
    789,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          // 이렇게 Padding 로 감싸면 padding 을 줄 수 있다.
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            // 밑의 정렬을 통해 왼쪽에 숫자를 붙인다.
            // 아니면, 밑의 텍스트컬럼을 sizedBox로 감싸서 폭을 무한대로주고 거기에 정렬을 줘도 된다.
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(onPressed: onSettingsPop),
              _Body(randomNumbers: randomNumbers),
              _Footer(onPressed: onRandomNumberGenerate)
            ],
          ),
        ),
      ),
    );
  }

  void onSettingsPop() async {
    // list - add
    // [HomeScreen(), SettingScreen()]
    // 나중에 pop을 통해 값을 받을 때, async를 통해 받아야한다.

    // 이 result는 사실은 int? 타입이다. 아무것도 반환 안 할수도 있기 때문이다.
    // 저장 안 누르고 뒤로 가버리면 null이 들어 올 수도 있다.
    // 그래서 어떻게든 null값이 들어올 수 있다는 가정하에 코드를 짜야한다.
    final int? result = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SettingsScreen(maxNumber: maxNumber);
        },
      ),
    );

    if (result != null) {
      setState(() {
        maxNumber = result;
      });
    }
  }

  onRandomNumberGenerate() {
    final rand = Random();

    // Set를 통한 중복제거
    final Set<int> newNumbers = {};

    // 중복제거로 숫자가 증발하는 것을 제외하기 위해
    while (newNumbers.length != 3) {
      final number = rand.nextInt(maxNumber);

      newNumbers.add(number);
    }

    setState(() {
      randomNumbers = newNumbers.toList();
    });
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;

  const _Header({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '랜덤 숫자 생성기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.settings,
            color: RED_COLOR,
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> randomNumbers;

  const _Body({required this.randomNumbers, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: randomNumbers
            // 디테일한 부분은 asMap()을 사용해 인덱스를 이용해 처리 가능하다.
            .asMap()
            .entries
            .map(
              (x) => Padding(
                padding: EdgeInsets.only(bottom: x.key == 2 ? 0 : 16.0),
                child: NumberRow(number: x.value,)
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;

  const _Footer({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // 1. 무한대로 차지하고 싶으면 sizedBox로 감싸고 double.infinity 를 쓰자.
      // 2. 두번째 로는 Row로 감싸고 Expanded로 늘려도 된다.
      // 3. 아니면, Container로 감싸고 sizedBox랑 똑같이 하면된다.
      // Container이 좀더 다양한 기능을 가진상위 박스이다.
      // 그러면 왜 sizedBox를 쓰냐? 뉘앙스의 차이다. 코드가독성을 위해서다.
      width: double.infinity,
      child: ElevatedButton(
        // 이렇게 버튼도 스타일 파라미터가 있다.
        style: ElevatedButton.styleFrom(
          backgroundColor: RED_COLOR,
        ),
        onPressed: onPressed,
        child: Text(
          '생성하기!',
        ),
      ),
    );
  }
}
