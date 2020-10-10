// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void common() {
    final Container container = Container();
    container.registerFactory<GlobalRepository, CategoryRepositoryImpl>(
        (c) => CategoryRepositoryImpl(networkService: c<NetworkService>()));
    container.registerFactory<AuthenticationRepository, LoginRepositoryImpl>(
        (c) => LoginRepositoryImpl(networkService: c<NetworkService>()));
    container.registerFactory<ArtistProfileRepository,
            ArtistProfileRepositoryImpl>(
        (c) =>
            ArtistProfileRepositoryImpl(networkService: c<NetworkService>()));
    container.registerFactory<AllArtistInfoRepository,
            AllArtistInfoRepositoryImpl>(
        (c) =>
            AllArtistInfoRepositoryImpl(networkService: c<NetworkService>()));
    container.registerFactory<AuditionRepository, AuditionRepositoryImpl>(
        (c) => AuditionRepositoryImpl(c<NetworkService>()));
    container.registerFactory<AgencyProfileRepository,
            AgencyProfileRepositoryImpl>(
        (c) =>
            AgencyProfileRepositoryImpl(networkService: c<NetworkService>()));
    container.registerFactory<VideoRepository, VideoRepositoryImpl>(
        (c) => VideoRepositoryImpl(networkService: c<NetworkService>()));
  }

  void development() {
    final Container container = Container();
    container.registerSingleton((c) => NetworkService.development());
  }

  void production() {
    final Container container = Container();
    container.registerSingleton((c) => NetworkService.production());
  }
}
