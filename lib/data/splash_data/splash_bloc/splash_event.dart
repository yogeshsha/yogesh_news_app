part of 'splash_bloc.dart';


abstract class SplashEvent extends Equatable {
  final Map? body;
  final String? code;

  const SplashEvent({this.body,this.code});

  @override
  List<Object> get props => [];
}


class SendOtp extends SplashEvent {
  const SendOtp({required super.body});
}

class SendEmailOtp extends SplashEvent {
  const SendEmailOtp({required super.body});
}

class SendBusinessOtp extends SplashEvent {
  const SendBusinessOtp({required super.body});
}

class CheckUniquePhoneNumber extends SplashEvent {
  const CheckUniquePhoneNumber({required super.body});
}

class CheckPhoneNumber extends SplashEvent {
  const CheckPhoneNumber({required super.body});
}

class CheckEmail extends SplashEvent {
  const CheckEmail({required super.body});
}

class SocialVendor extends SplashEvent {
  const SocialVendor({required super.body});
}

class UpdateUser extends SplashEvent {
  const UpdateUser({required super.body});
}

class GetUser extends SplashEvent {
  const GetUser({required super.body});
}

class GetBasicInfoUser extends SplashEvent {
  const GetBasicInfoUser();
}

class AddBasicInfoUser extends SplashEvent {
  const AddBasicInfoUser({required super.body});
}

class UpdateDoc extends SplashEvent {
  const UpdateDoc({required super.body});
}

class GetVendorUser extends SplashEvent {
  const GetVendorUser({super.body = const {}});
}

class GetStates extends SplashEvent {
  const GetStates();
}

class GetCities extends SplashEvent {
  const GetCities({required super.code});
}

class UpdateVendorUser extends SplashEvent {
  const UpdateVendorUser({required super.body});
}

class UpdateVendor extends SplashEvent {
  const UpdateVendor({required super.body});
}



class FetchInitialSplash extends SplashEvent {
  const FetchInitialSplash();
}

class GetUserDetails extends SplashEvent {
  const GetUserDetails();
}
