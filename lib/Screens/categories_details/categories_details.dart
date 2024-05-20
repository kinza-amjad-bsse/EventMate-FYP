import 'package:event_mate/Exporter/exporter.dart';
import 'body/cat_detail_body.dart';

class CategoriesDetailsScreen extends StatelessWidget {
  const CategoriesDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CategoriesDetailsBody(),
    );
  }
}
