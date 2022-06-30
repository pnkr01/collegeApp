import 'package:college_app/global.dart';
import 'package:college_app/views/home/nav_bars/user.dart';

class UserPrefrence {
  static final myUser = User(
      name: sharedPreferences!.getString('fullName') ?? "",
      email: sharedPreferences!.getString('email') ?? "no",
      isDarkMode: false,
      phone: sharedPreferences!.getString("phoneNumber") ?? "");
}
