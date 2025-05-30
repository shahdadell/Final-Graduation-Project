import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Profile_screen/data/repo/profile_repo.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepo profileRepo;

  ProfileBloc(this.profileRepo) : super(ProfileInitial()) {
    on<FetchProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profile = await profileRepo.fetchProfile(event.userId);
        emit(ProfileLoaded(profile));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<UpdateProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        final response = await profileRepo.updateProfile(
          event.userId,
          event.username,
          event.email,
          event.phone,
          event.password, // إضافة كلمة السر
          event.image, // إضافة الصورة
        );
        if (response.status == 'success') {
          emit(ProfileUpdated(response));
          final updatedProfile = await profileRepo.fetchProfile(event.userId);
          emit(ProfileLoaded(updatedProfile));
        } else {
          emit(ProfileError(response.message ?? 'Failed to update profile'));
        }
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}
