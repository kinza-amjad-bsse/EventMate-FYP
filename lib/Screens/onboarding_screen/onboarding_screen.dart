import 'package:event_mate/Exporter/exporter.dart';
import 'package:event_mate/Screens/onboarding_screen/widgets/onboarding_body.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnboardingBody(),
    );
  }
}
