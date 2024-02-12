import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:payment/core/utils/cache_helper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  String? version;
  Future<void> logOut() async {
    emit(ProfileLoading());
    try {
      await FirebaseAuth.instance.signOut();
      CacheHelper.removeData(key: 'uid');
      emit(ProfileSuccess());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> getDataApp() async {
    emit(GetVersionLoading());
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      version = packageInfo.version;
      emit(GetVersionSuccess());
    } catch (e) {
      emit(GetVersionError(e.toString()));
      
    }
    
  }
}
