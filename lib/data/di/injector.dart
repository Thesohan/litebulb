import 'package:kiwi/kiwi.dart';
import 'package:new_artist_project/app_config.dart';
import 'package:new_artist_project/data/network/network_service.dart';
import 'package:new_artist_project/data/repository/all_agency_profile_repositoy/agency_profile_repository.dart';
import 'package:new_artist_project/data/repository/all_agency_profile_repositoy/agency_profile_repository_impl.dart';
import 'package:new_artist_project/data/repository/all_artist_info_repository/all_artist_info_repository.dart';
import 'package:new_artist_project/data/repository/all_artist_info_repository/all_artist_info_repository_impl.dart';
import 'package:new_artist_project/data/repository/artist_profile_repository/artist_profile_repository.dart';
import 'package:new_artist_project/data/repository/artist_profile_repository/artist_profile_repository_impl.dart';
import 'package:new_artist_project/data/repository/audition_repository/audition_repository.dart';
import 'package:new_artist_project/data/repository/audition_repository/audition_repository_impl.dart';
import 'package:new_artist_project/data/repository/category_repository/global_repository.dart';
import 'package:new_artist_project/data/repository/category_repository/global_repository_impl.dart';
import 'package:new_artist_project/data/repository/loginRepository/authentication_repository_impl.dart';
import 'package:new_artist_project/data/repository/loginRepository/authentication_repository.dart';
import 'package:new_artist_project/data/repository/video_repository/video_repository.dart';
import 'package:new_artist_project/data/repository/video_repository/video_repository_impl.dart';

part 'injector.g.dart';

abstract class Injector {
  @Register.factory(GlobalRepository, from: CategoryRepositoryImpl)
  @Register.factory(AuthenticationRepository, from: LoginRepositoryImpl)
  @Register.factory(ArtistProfileRepository, from: ArtistProfileRepositoryImpl)
  @Register.factory(AllArtistInfoRepository, from: AllArtistInfoRepositoryImpl)
  @Register.factory(AuditionRepository, from: AuditionRepositoryImpl)
  @Register.factory(AgencyProfileRepository, from: AgencyProfileRepositoryImpl)
  @Register.factory(VideoRepository,from:VideoRepositoryImpl)
  void common();

  @Register.singleton(NetworkService, constructorName: 'development')
  void development();

  @Register.singleton(NetworkService, constructorName: 'production')
  void production();

  static void setup() {
    final injector = _$Injector();
    injector.common();
    if (AppConfig.appFlavor == AppFlavor.development) {
      injector.development();
    } else {
      injector.production();
    }
  }
}
