import 'dart:math';

class FlutterDev {
  FlutterDev([String name = 'abhiroop']) {
    print('I am $name, and I am a flutter Developer');
  }
}

void basic() {
  FlutterDev('YOLO');
}

class Human {
  //late final -> can only assign once
  String _firstName = "";
  String _lastName = "";
  late final num _height;
  late final num _weight;

  Human(
      {required String firstName,
      required String lastName,
      required num height,
      required num weight}) {
    this._firstName = firstName;
    this._lastName = lastName;
    this._height = height;
    this._weight = weight;
  }

  get bmi {
    return _weight / pow((_height / 100), 2);
  }

  String get fullName {
    return "$_firstName $_lastName";
  }

  set fullName(String data) {
    var listOfWords = data.split(' ');
    if (listOfWords.length == 2) {
      _firstName = listOfWords[0];
      _lastName = listOfWords[1];
    } else
      throw Exception('Error: fullname must have only two words');
  }
}

void getterSetter() {
  Human me = Human(
      firstName: 'Abhiroop', lastName: 'Mukherjee', height: 180, weight: 70);

  print('BMI: ${me.bmi}');
  print('Fullname: ${me.fullName}');
  me.fullName = "Noob Coder";
  print('Fullname: ${me.fullName}');
}

class Media {
  String _title = "";
  String _type = "";
  Media() {
    _type = "Class";
  }
  void setMediaTitle(String mediaTitle) {
    _title = mediaTitle;
  }

  String getMediaTitle() => _title;
  String getMediaType() => _type;
}

class Book extends Media {
  String _author = "";
  String _isbn = "";
  Book() {
    setMediaTitle('Subclass');
  }

  void setBookTitle(String bookTitle) => setMediaTitle(bookTitle);
  String getBookTitle() => getMediaTitle();
  String getBookAuthor() => _author;
  String getBookISBN() => _isbn;
  void setBookAuthor(String bookAuthor) {
    _author = bookAuthor;
  }

  void setBookISBN(String bookISBN) {
    _isbn = bookISBN;
  }
}

void extend() {
  var myMedia = Media();
  myMedia.setMediaTitle('Tron');
  print('Title: ${myMedia.getMediaTitle()}');
  print('Type: ${myMedia.getMediaType()}');
  var myBook = Book();
  myBook.setBookTitle("Jungle Book");
  myBook.setBookAuthor("R Kipling");
  print('Title: ${myBook.getMediaTitle()}');
  print('Author: ${myBook.getBookAuthor()}');
  print('Type: ${myBook.getMediaType()}');
}

abstract class Person {
  String name = "";
  int age = -1;

  void about();
}

class Doctor with Person {
  String specialization = "";
  Doctor(String doctorName, int doctorAge, String specialization) {
    name = doctorName;
    age = doctorAge;
    this.specialization = specialization;
  }

  void about() {
    print('$name is $age years old. He is $specialization specialist.');
  }
}

void mixins() {
  Doctor doctor = Doctor("Harish Chandra", 54, 'child');
  print(doctor.name);
  print(doctor.age);
  doctor.about();
}

void main() {
  basic();
  getterSetter();
  extend();
  mixins();
}
