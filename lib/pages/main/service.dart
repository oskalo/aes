import 'dart:math';

import 'dart:convert';

List<String> GenerateKeys(int len) {
  List<String> resp = [];

  return fillArray(len, resp);
}

String generateAES256Key() {
  var random = Random.secure();
  var values = List<int>.generate(32, (i) => random.nextInt(256));
  var aes256Key = base64Url.encode(values);
  return aes256Key;
}

List<String> fillArray(int lenKeys, List<String> keys) {
  if (keys.length == lenKeys) {
    return keys;
  }

  var newElem = generateAES256Key();
  if (keys.contains(newElem)) {
    fillArray(lenKeys, keys);
  } else {
    keys.add(newElem);
    fillArray(lenKeys, keys);
  }

  return keys;
}
