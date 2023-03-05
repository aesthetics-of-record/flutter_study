import 'package:flutter/material.dart';
import 'package:random_number_generator/component/number_row.dart';
import '../constant/color.dart';

class SettingsScreen extends StatefulWidget {
  final int maxNumber;

  const SettingsScreen({required this.maxNumber, Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double maxNumber = 1000;

  @override
  void initState() {
    super.initState();

    maxNumber = widget.maxNumber.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _body(
                maxNumber: maxNumber,
              ),
              _footer(
                onSliderChanged: onSliderChanged,
                maxNumber: maxNumber,
                onButtonPressed: onButtonPressed,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSliderChanged(double val) {
    setState(() {
      maxNumber = val;
    });
  }

  void onButtonPressed() {
    // 이렇게 값을 넘겨줄 수 있다. 데이터는 원래 푸쉬했던 곳에서 받으면된다.
    Navigator.of(context).pop(maxNumber.toInt());
  }
}

class _body extends StatelessWidget {
  final double maxNumber;

  const _body({required this.maxNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(
        number: maxNumber.toInt(),
      ),
    );
  }
}

class _footer extends StatelessWidget {
  final ValueChanged<double>? onSliderChanged;
  final double maxNumber;
  final VoidCallback onButtonPressed;

  const _footer(
      {required this.onSliderChanged,
      required this.maxNumber,
      required this.onButtonPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Slider(
          // 이 슬라이드 자체로는 다시 그려주는 기능을 하지 못한다.
          // 그래서 setState를 통해 다시 빌드를 해줘야한다.
          value: maxNumber,
          min: 1000,
          max: 100000,
          onChanged: onSliderChanged,
        ),
        ElevatedButton(
            onPressed: onButtonPressed,
            style: ElevatedButton.styleFrom(backgroundColor: RED_COLOR),
            child: Text('저장!'))
      ],
    );
  }
}
