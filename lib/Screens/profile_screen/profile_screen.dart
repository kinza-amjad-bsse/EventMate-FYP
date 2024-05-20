import 'package:event_mate/Exporter/exporter.dart';
import 'package:event_mate/Model/user_model/user_model.dart';
import 'widget/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.model,
  });
  final UserModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ProfileBody(
        model: model,
      ),
    );
  }
}
