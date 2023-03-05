import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 이렇게 색깔에, 맵처럼 대괄호를 쓸 수 있다. 기본값은 500이다.
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        bottom: false, // 이러면 아랫부분만 safearea를 적용하지 않는다.
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              _TopPart(
                selectedDate: selectedDate,
                onPressed: onHeartPressed,
              ),
              _BottomPart(),
            ],
          ),
        ),
      ),
    );
  }

  void onHeartPressed(){
      // dialog
      showCupertinoDialog(
          context: context,
          barrierDismissible: true, // 밖을 누르면 닫는 기능
          // 밑의 builder은 그냥 build함수라고 생각하면 된다.
          builder: (BuildContext context) {
            return Align(
              // Container만 쓰면 어디 정렬할 지 몰라서 크기를 정해도 다 채운다. 그래서 Align으로 덮어줘야한다.
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                height: 300.0,
                child: CupertinoDatePicker(
                  // 이건 모드에 따라 시간이나오거나 연월이 나오거나 한다.
                  mode: CupertinoDatePickerMode.date,
                  // 시작설정안하면 처음 시작하는 현재시간은 현재시각이다. 그래서 시분초때문에 맥스를 오버한다.
                  initialDateTime: selectedDate,
                  maximumDate: DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                  ),
                  onDateTimeChanged: (DateTime date) {
                    setState(() { // setState는 stateful위젯 에서 밖에 못 쓴다.
                      selectedDate = date;
                    });
                  },
                ),
              ),
            );
          });
  }
}

class _TopPart extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPressed;

  _TopPart({
    required this.selectedDate,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 이렇게 하면, 테마를 가져올 수 있습니다. context는 이 빌드컨텍스트의 컨텍스트죠.
    final theme = Theme.of(context);
    // 물론 아무거나 다 가져올 수 있는 건 아닙니다. 우리가 이전에 써봤던 미디아쿼리.of(contest). ~~ 를 써봤죠.
    // 이 of라는 컨스트럭터를 사용하는 위젯의 특징인 inherited 위젯이라는 겁니다.
    // 이렇게 하면 _TopPart 에서 가장 가까운 미디아쿼리나 띰을 가져올 수가 있는거에요.
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'U&I',
            style: theme.textTheme.headline1,
          ),
          Column(
            children: [
              Text(
                '우리 처음 만난날',
                style: theme.textTheme.headline2,
              ),
              Text(
                '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
                style: theme.textTheme.bodyText1,
              ),
            ],
          ),
          IconButton(
            iconSize: 60.0,
            onPressed: this.onPressed,
            icon: Icon(
              Icons.favorite,
              color: Colors
                  .red, // 쭉 작성하면서 느낀 건데, 파라미터이름은 소문자시작 클래스이름은 대문자시작 인 것 같다.
            ),
          ),
          Text(
            'D+${DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                ).difference(selectedDate).inDays + 1}',
            style: theme.textTheme.bodyText2,
          ),
        ],
      ),
    ); // 리턴 끝부분에는 세미콜론을 넣어줘야한다.
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Image.asset(
        'asset/img/middle_image.png',
      ),
    );
  }
}
