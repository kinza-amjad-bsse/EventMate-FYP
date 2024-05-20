import '../../Exporter/exporter.dart';
import '../../Screens/widgets/my_text_form_field/my_text_form_field.dart';

class EditProfileModel {
  String title;
  TextEditingController controller = TextEditingController();
  late Widget textField;
  bool isPhoneNumber = false;
  bool enabled = false;
  TextInputType? keyboardType;
  bool isOptional;
  dynamic onTapFunction;

  EditProfileModel({
    required this.title,
    this.isPhoneNumber = false,
    this.onTapFunction,
    this.enabled = true,
    required this.isOptional,
    this.keyboardType,
  }) {
    textField = SizedBox(
      width: double.infinity,
      child: MyTextFormField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        hint: "Enter your $title",
        isPhoneNumber: isPhoneNumber,
        onTapFunction: () {
          onTapFunction();
        },
        enabled: enabled,
      ),
    );
  }
}
