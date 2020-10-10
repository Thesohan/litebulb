import 'package:new_artist_project/blocs/all_agency_profile_bloc/agency_profile_bloc_event.dart';
import 'package:new_artist_project/blocs/base/baseEvent.dart';
import 'package:new_artist_project/blocs/base/base_bloc.dart';
import 'package:new_artist_project/data/cache/in_memory_cache/shared_pref_handler.dart';
import 'package:new_artist_project/data/models/api/request/agency_profile_request.dart';
import 'package:new_artist_project/data/models/api/request/artist_exp_or_cred_request.dart';
import 'package:new_artist_project/data/models/api/request/artist_id_request.dart';
import 'package:new_artist_project/data/models/api/request/block_or_unblock_agency_request.dart';
import 'package:new_artist_project/data/models/api/response/agency_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/all_agency_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_cred_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_exp_response.dart';
import 'package:new_artist_project/data/models/api/response/artist_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/blocked_agency_profile_response.dart';
import 'package:new_artist_project/data/models/api/response/simple_message_response.dart';
import 'package:new_artist_project/data/repository/all_agency_profile_repositoy/agency_profile_repository.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:new_artist_project/data/resource.dart';
import 'package:rxdart/rxdart.dart';

class AgencyProfileBloc extends BaseBloc<AgencyDataEvent> {
  AgencyProfileBloc({AgencyProfileRepository agencyProfileRepository})
      : _agencyProfileRepository = agencyProfileRepository ??
            kiwi.Container().resolve<AgencyProfileRepository>();
  final AgencyProfileRepository _agencyProfileRepository;

  final BehaviorSubject<Resource<AllAgencyProfileResponse>>
      _allAgencyProfileResponseSubject =
      BehaviorSubject<Resource<AllAgencyProfileResponse>>();

  Observable<Resource<AllAgencyProfileResponse>>
      get allAgencyProfileResponseObservable =>
          _allAgencyProfileResponseSubject.stream;

  final BehaviorSubject<Resource<CredResponse>>
      _agencyCreditResponsePublishSubject =
      BehaviorSubject<Resource<CredResponse>>();

  Observable<Resource<CredResponse>> get agencyCreditResponseObservable =>
      _agencyCreditResponsePublishSubject.stream;

  final BehaviorSubject<Resource<ExpOrProResponse>>
      _agencyProjectResponsePublishSubject =
      BehaviorSubject<Resource<ExpOrProResponse>>();

  Observable<Resource<ExpOrProResponse>> get agencyProjectResponseObservable =>
      _agencyProjectResponsePublishSubject.stream;

  final BehaviorSubject<Resource<AllAgencyProfileResponse>>
      _blockedAgencyResponsePublishSubject =
      BehaviorSubject<Resource<AllAgencyProfileResponse>>();

  Observable<Resource<AllAgencyProfileResponse>>
      get blockedAgencyResponseObservable =>
          _blockedAgencyResponsePublishSubject.stream;

  @override
  void handleEvent(AgencyDataEvent event) {
    if (event is FetchAllAgencyEvent) {
      _fetchAllAgency(event);
    } else if (event is FetchAgencyExpOrCredEvent) {
      _fetchAgencyCredOrPro(event);
    } else if (event is FetchBlockedAgencyEvent) {
      _fetchBlockAgency(event);
    }
    else if(event is BlockOrUnBlockAgencyEvent){
      _blockOrUnBlockAgency(event);
    }
  }

  @override
  void dispose() {
    _allAgencyProfileResponseSubject.close();
    _agencyCreditResponsePublishSubject.close();
    _agencyProjectResponsePublishSubject.close();
    _blockedAgencyResponsePublishSubject.close();
    super.dispose();
  }

  void _fetchAllAgency(FetchAllAgencyEvent event) async {
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    ArtistProfileResponse artistProfileResponse = await sharedPrefHandler.getArtistBio();
    if(artistProfileResponse!=null){
      AgencyProfileRequest agencyProfileRequest = AgencyProfileRequest(username: event.agencyProfileRequest.username,artist_id: artistProfileResponse.id,);
      _agencyProfileRepository
          .fetchAgencyProfile(agencyProfileRequest: agencyProfileRequest)
          .listen((Resource<AllAgencyProfileResponse> res) {
        _allAgencyProfileResponseSubject.add(res);
      });
    }
    else{
      _agencyProfileRepository
          .fetchAgencyProfile(agencyProfileRequest: event.agencyProfileRequest)
          .listen((Resource<AllAgencyProfileResponse> res) {
        _allAgencyProfileResponseSubject.add(res);
      });
    }
  }

  void _fetchAgencyCredOrPro(FetchAgencyExpOrCredEvent event) async {
    if (event.value == 'credits') {
      Resource<CredResponse> credResponseResource =
          await _agencyProfileRepository
              .fetchAgencyCredit(
                agencyCredRequest: ExpOrCred(
                  value: event.value,
                  id: event.id,
                ),
              )
              .last;
      if (credResponseResource?.data?.data != null) {
        _agencyCreditResponsePublishSubject.add(credResponseResource);
      }
    } else if (event.value == 'projects') {
      Resource<ExpOrProResponse> projectResponseResource =
          await _agencyProfileRepository
              .fetchAgencyProject(
                agencyCredRequest: ExpOrCred(
                  value: event.value,
                  id: event.id,
                ),
              )
              .last;
      if (projectResponseResource?.data?.data != null) {
        _agencyProjectResponsePublishSubject.add(projectResponseResource);
      }
    }
  }

  void _fetchBlockAgency(FetchBlockedAgencyEvent event) async {
    _blockedAgencyResponsePublishSubject.add(null);
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    ArtistProfileResponse artistProfileResponse =
        await sharedPrefHandler.getArtistBio();
    if (artistProfileResponse != null) {
      Resource<BlockedAgencyProfileResponse> res = await _agencyProfileRepository
          .fetchBlockedAgencies(
              artistIdRequest:
                  ArtistIdRequest(artistid: artistProfileResponse.id))
          .last;
      if (res != null && res.data!=null && res.data.data!=null) {
        List<AgencyProfileResponse>blockedAgencies =[];
        res.data?.data?.forEach((agencyList){
        blockedAgencies.add(agencyList[0]);
        });
        AllAgencyProfileResponse allAgencyProfileResponse = AllAgencyProfileResponse(data: blockedAgencies,message: res.message);
        Resource<AllAgencyProfileResponse>resource= Resource(data: allAgencyProfileResponse,message: res.message,status: res.status);
        _blockedAgencyResponsePublishSubject.add(resource);
      }
    }
  }

  void _blockOrUnBlockAgency(BlockOrUnBlockAgencyEvent event)async {
    SharedPrefHandler sharedPrefHandler = SharedPrefHandler();
    ArtistProfileResponse artistProfileResponse = await sharedPrefHandler.getArtistBio();
    if(artistProfileResponse!=null){
      BlockOrUnblockAgencyRequest blockOrUnblockAgencyRequest = BlockOrUnblockAgencyRequest(agencyid: event.agencyId,artistid: artistProfileResponse.id,);
     Resource<SimpleMessageResponse> res = await _agencyProfileRepository.blockOrUnblockAgency(blockOrUnblockAgencyRequest).last;
     if(res!=null){
       print(res.data.message);

      Resource<AllAgencyProfileResponse>resource;
      if(!event.isBlocEvent){
        resource=  await _blockedAgencyResponsePublishSubject.first;
      }
      if(resource!=null ){
        List<AgencyProfileResponse>agencies = resource.data.data;
        agencies.removeWhere((agency){
        return event.agencyId ==agency.id;
        });
        AllAgencyProfileResponse allAgencyProfileResponse = AllAgencyProfileResponse(data: agencies,message: res.message);
        resource= Resource(data: allAgencyProfileResponse,message: res.message,status: res.status);
        _blockedAgencyResponsePublishSubject.add(resource);
      }
     }
      event.completer.complete(res.data.message);

    }
  }
}
