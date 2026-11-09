import '../../../../core/database/app_database.dart';
import '../models/member_model.dart';

class MemberLocalDataSource {
  final AppDatabase appDatabase;

  MemberLocalDataSource(this.appDatabase);

  Future<MemberModel?> getMember() async {
    final db = await appDatabase.database;

    final result = await db.query(AppDatabase.memberTable, limit: 1);

    if (result.isEmpty) return null;

    return MemberModel.fromMap(result.first);
  }

  Future<void> insertMember(MemberModel member) async {
    final db = await appDatabase.database;

    await db.insert(AppDatabase.memberTable, member.toMap());
  }
}
