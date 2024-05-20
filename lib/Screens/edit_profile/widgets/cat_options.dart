import '../../../Exporter/exporter.dart';

class ProfileCategoryBubble extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const ProfileCategoryBubble({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(
          top: 10.h,
          bottom: 10.h,
          left: 20.w,
          right: 20.w,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.appTheme : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
