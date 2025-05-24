import '../../data/model/response/profile_screen_response/EditeProfileResponse.dart';
import '../../data/model/response/profile_screen_response/ProfileScreenResponse.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileScreenResponse profile;

  ProfileLoaded(this.profile);
}

class ProfileUpdated extends ProfileState {
  final EditeProfileResponse response;

  ProfileUpdated(this.response);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
