import 'dart:math';

import 'dart:convert';

List<String> GenerateKeys(int Keys) {
  List<String> resp = [];

  int i = 0;
  for (; i < Keys;) {
    resp.add(generateAES256Key());
    i++;
  }
  return resp;
}

String generateAES256Key() {
  var random = Random.secure();
  var values = List<int>.generate(32, (i) => random.nextInt(256));
  var aes256Key = base64Url.encode(values);
  return aes256Key;
}
