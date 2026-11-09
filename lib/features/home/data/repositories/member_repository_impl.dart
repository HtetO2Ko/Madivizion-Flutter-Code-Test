import '../../domain/entities/member.dart';
import '../../domain/repositories/member_repository.dart';
import '../datasources/member_local_data_source.dart';

class MemberRepositoryImpl implements MemberRepository {
  final MemberLocalDataSource localDataSource;

  MemberRepositoryImpl(this.localDataSource);

  @override
  Future<Member?> getMember() async {
    return localDataSource.getMember();
  }
}
