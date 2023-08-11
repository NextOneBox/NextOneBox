
import 'Login_screen.dart';
import 'navbar.dart';

import 'welcome.dart';

class AuthService {
  handleAuthState()  {
    if (account!.isNotEmpty) {
      return Bottomapp();
    } else {
      return Loginscreen();
    }
   
  }
}
