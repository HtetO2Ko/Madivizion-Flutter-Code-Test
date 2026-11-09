import 'dart:convert';

import 'package:flutter/services.dart';

import '../../features/home/data/datasources/member_local_data_source.dart';
import '../../features/home/data/models/member_model.dart';

class MemberSeeder {
  final MemberLocalDataSource localDataSource;

  MemberSeeder(this.localDataSource);

  Future<void> seedIfNeeded() async {
    final existingMember = await localDataSource.getMember();

    if (existingMember != null) return;

    final jsonString = await rootBundle.loadString('assets/data/member.json');

    final Map<String, dynamic> json =
        jsonDecode(jsonString) as Map<String, dynamic>;

    final member = MemberModel.fromJson(json);

    await localDataSource.insertMember(member);
  }
}
