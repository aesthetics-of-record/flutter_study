import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  // 원래는 runApp이 실행되기 전에 이 코드가 실행된다.
  // 근데 지금은 그것을 실행하기 전에 코드를 실행해줘야하니,
  // 이거를 먼저 실행한다음에 다른 함수를 실행하는겁니다.
  // 플러터 프레임워크가 준비되었는지 확인하는 코드입니다.
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'NotoSans'),
    home: HomeScreen(),
  ));
}
