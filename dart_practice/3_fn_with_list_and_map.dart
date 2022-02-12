void maps() {
  // map  -> collection of key value pairs
  //      -> both key and value can be of different types (and can also be defined)
  //      -> keys should be unique, values can be anything

  //three types of maps
  // 1) plain hashmap -> unordered key pair, order is not guranteed
  // 2) LinkedHashMap -> order is the insertion order
  // 3) sorted map like SplayTreeMap -> order is sorted to some parameter

  Map human = {'age': 18, 'height': 180};

  print(human['age']);
  print(human['height']);

  //check key exist
  var param = 'weight';

  if (human[param] == null)
    print('key does not exist');
  else
    print('$param is ${human[param]}');

  // adding value to map
  if (human[param] == null) human[param] = 75;

  print('$param is ${human[param]}');

  for (var key in human.keys) print('$key is ${human[key]}');
}

void lists() {
  // list -> ordered group of objects (type can be defined)
  List<String> listMonths = ['January', 'February', 'March'];
  listMonths.forEach((element) {
    // note: takes function as a parameter
    print(element);
  });
}

void main() {
  maps();
  lists();
}
