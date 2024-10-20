import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiKey {
  static var apiKey = '${dotenv.env['APIKEY']}';
}
