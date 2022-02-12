import 'dart:collection';

const int DAY_IN_WEEKS = 7;
final int DAY_IN_APRIL = 31;

//

// var data can be changed
// final vs const
// both are used do say that value of data can't be changed
// const is compile time, const objects will have same address
array() => const [1, 2];
void checkConst() {
  var a = array();
  var b = array();

  print(a == b); //will give true as const data have same reference
}

void forCode() {
  String myMessage = 'Dart is super fun!';
  for (int i = 0; i < 5; i++) print('Hello $myMessage');
}

void whileLoop() {
  int i = 0;
  while (i <= 4) print('Hello ${i++}');
}

void helloList() {
  var namesOfTheWeek = [
    'mon',
    'tues',
    'wed',
    'thurs',
    'fri'
  ]; //python style list

  for (var name in namesOfTheWeek) print(name); // for in loop

  // for (int i = 0; i < namesOfTheWeek.length; i++) print(namesOfTheWeek[i]); for loop
}

void helloMaps() {
  var daysInWeek = new Map();
  daysInWeek[0] = 'Sun';
  daysInWeek[1] = 'Mon';
  daysInWeek[2] = 'Tues';

  // var daysInWeek = {0: 'Sun', 1: 'Mon', 2: 'Tues'}; //python style map
  print('Hello $daysInWeek');
}

// refer to https://stackoverflow.com/questions/13264230/what-is-the-difference-between-named-and-positional-parameters-in-dart
// to see positional optional parameter using [] and named optional parameter using {}
class FlutterDev {
  FlutterDev({String name = 'user'}) {
    print('$name is a Flutter Dev');
  }
}

void classCode() {
  FlutterDev();
}

void main() {
  print('days in week: $DAY_IN_WEEKS');
  checkConst();
  forCode();
  whileLoop();
  helloList();
  helloMaps();
  classCode();
}
