import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime? selectedDay;
  DateTime focusedDay = DateTime.now();

  final defaultBoxDeco = BoxDecoration(
    borderRadius: BorderRadius.circular(6.0),
    color: Colors.grey[200],
  );
  final defaultTextStyle = TextStyle(
    color: Colors.grey[600],
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_KR',
      focusedDay: focusedDay,
      firstDay: DateTime(1000),
      lastDay: DateTime(3000),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
      ),
      calendarStyle: CalendarStyle(
          isTodayHighlighted: false,
          defaultDecoration: defaultBoxDeco,
          weekendDecoration: defaultBoxDeco,
          selectedDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color: PRIMARY_COLOR,
              width: 1.0,
            ),
          ),
          defaultTextStyle: defaultTextStyle,
          weekendTextStyle: defaultTextStyle,
          selectedTextStyle: defaultTextStyle.copyWith(
            color: PRIMARY_COLOR,
          ),
          outsideDecoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          )),
      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        setState(
          () {
            this.selectedDay = selectedDay;
            this.focusedDay = selectedDay;
          },
        );
      },
      selectedDayPredicate: (DateTime date) {
        if (selectedDay == null) {
          return false;
        }

        // 시분초까지 같을 필요는 없으니, 연월일만 검사
        return date.year == selectedDay!.year &&
            date.month == selectedDay!.month &&
            date.day == selectedDay!.day;
      },
    );
  }
}
