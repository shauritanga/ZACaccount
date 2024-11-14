import 'package:zaccount/data/local_database_helper.dart';
import 'package:zaccount/models/activity.dart';

class ActivityDataSource {
  ActivityDataSource({required this.databaseHelper});
  final DatabaseHelper databaseHelper;

  Future<void> insertActivity(Activity activity) async {
    await databaseHelper.insert('activities', activity.toJson());
  }

  Future<List<Activity>> getActivities() async {
    List<Map<String, dynamic>> maps =
        await databaseHelper.fetchAll("activities");
    List<Activity> activities = List.generate(maps.length, (index) {
      return Activity.fromJson(maps[index]);
    });
    return activities;
  }

  Future<void> updateActivity(Activity activity) async {
    await databaseHelper.update(
      'activities',
      activity.toJson(),
      'id = ?',
      [activity.id],
    );
  }

  Future<void> deleteActivity(String id) async {
    await databaseHelper.delete('activities', 'id = ?', [id]);
  }
}
