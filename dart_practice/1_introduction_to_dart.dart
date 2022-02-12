BigInt factorial(int number) {
  return number == 1 ? BigInt.one : BigInt.from(number) * factorial(number - 1);
}

int intFactorial(int number) {
  return number == 1 ? 1 : number * intFactorial(number - 1);
}

void main() {
  double intData = 23;
  double doubleData = 23.123;
  String stringData = 'world';
  bool boolData = true;
  print('hello data: ${boolData}');

  bool isDartCool = true;

  if (isDartCool)
    print('Dart is cool');
  else
    print('dart is not cool');

  int number = 100;
  print('factorial of $number is ${intFactorial(number)}');
  print('factorial of $number is ${factorial(number)}');
}
