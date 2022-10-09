import 'package:flutter_dotenv/flutter_dotenv.dart';

bool isInitialized = false;

Future<void> checkOrLoadEnv() async {
  await dotenv.load(fileName: '.env');
  isInitialized = true;
}

String _getKey(String key) {
  if (isInitialized) {
    var value = dotenv.env[key];

    if (value == null) {
      throw Exception("key: " + key + " is missing in corresponding env file");
    }
    return value;
  } else {
    throw Exception("load env file first");
  }
}

String getBackendUri() {
  return _getKey('BACKEND_URI');
}
