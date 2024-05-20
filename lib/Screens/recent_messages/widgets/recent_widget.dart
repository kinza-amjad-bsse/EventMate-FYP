import 'package:event_mate/Exporter/exporter.dart';

class RecentWidget extends StatelessWidget {
  const RecentWidget({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.imageUrl,
  });
  final String name, lastMessage, time, imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
