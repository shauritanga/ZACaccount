import 'package:zaccount/data/datascource/activity_data_source.dart';
import 'package:zaccount/data/local_database_helper.dart';
import 'package:zaccount/domain/repositories/activity_rpository.dart';
import 'package:zaccount/models/activity.dart';

class ActivityRepositoryImpl extends ActivityRpository {
  final ActivityDataSource activityDataSource =
      ActivityDataSource(databaseHelper: DatabaseHelper());
  @override
  Future<void> addActivity(Activity activity) async {
    await activityDataSource.insertActivity(activity);
  }

  @override
  Future<List<Activity>> fetchActivities() async {
    return await activityDataSource.getActivities();
  }

  @override
  Future<void> updateActivity(Activity activity) async {
    await activityDataSource.updateActivity(activity);
  }

  @override
  Future<void> deleteActivity(String id) async {
    await activityDataSource.deleteActivity(id);
  }
}
