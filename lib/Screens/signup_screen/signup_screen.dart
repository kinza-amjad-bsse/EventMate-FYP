import 'package:event_mate/Exporter/exporter.dart';
import 'package:event_mate/Screens/signup_screen/widget/signup_body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SignUpScreenBody(),
    );
  }
}
