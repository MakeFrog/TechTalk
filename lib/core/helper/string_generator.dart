import 'dart:math';

abstract class StringGenerator {
  StringGenerator._();

  static String generateRandomString() {
    const String characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

    Random random = Random();

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < 20; i++) {
      int randomIndex = random.nextInt(characters.length);
      buffer.write(characters[randomIndex]);
    }

    return buffer.toString();
  }
}
