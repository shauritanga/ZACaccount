import 'package:zaccount/models/activity.dart';

abstract class ActivityRpository {
  Future<List<Activity>> fetchActivities();
  Future<void> addActivity(Activity activity);
  Future<void> updateActivity(Activity activity);
  Future<void> deleteActivity(String id);
}
