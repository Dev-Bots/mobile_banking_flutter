import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  if (token == null) {
    return "token not found";
  }
  return token;
}


// A file on its own cause we need the function in the whole data provider folder