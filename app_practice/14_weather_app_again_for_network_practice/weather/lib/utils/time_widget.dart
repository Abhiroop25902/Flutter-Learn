import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class TimeWidget extends StatefulWidget {
  const TimeWidget(
      {Key? key, this.textStyle = const TextStyle(), required this.timeString})
      : super(key: key);

  final String timeString;
  final TextStyle textStyle;

  @override
  _TimeWidgetState createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  String _timeString = "";
  late DateTime time;
  late Timer _timer;

  String get timeString => DateFormat(DateFormat.HOUR_MINUTE).format(time);

  @override
  void initState() {
    var timeStr = widget.timeString;
    //API has the tendency to give date in following format -> "2022-02-14 4:21"
    //lack of 0 in "4:21" (should be "04:21")
    //gives error in DateTime.parse, so covering that corner case
    if (timeStr.length == 15) {
      timeStr = timeStr.substring(0, 11) + '0' + timeStr.substring(11);
    }

    time = DateTime.parse(timeStr);
    _timeString = timeString;
    _timer =
        Timer.periodic(const Duration(seconds: 1), (timer) => _updateTime());
    super.initState();
  }

  void _updateTime() {
    setState(() {
      time = time.add(const Duration(seconds: 1));
      _timeString = timeString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _timeString,
      style: widget.textStyle,
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
