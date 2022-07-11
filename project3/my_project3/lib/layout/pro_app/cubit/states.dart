abstract class ProStates {}

class ProInitialState extends ProStates {}

class ProGetUserLoadingState extends ProStates {}

class ProGetUserSuccessState extends ProStates {}

class ProGetUserErrorState extends ProStates {
  final String error;

  ProGetUserErrorState(this.error);
}

class ProGetAllUsersLoadingState extends ProStates {}

class ProGetAllUsersSuccessState extends ProStates {}

class ProGetAllUsersErrorState extends ProStates {
  final String error;

  ProGetAllUsersErrorState(this.error);
}

class CreateFollowLoadingState extends ProStates {}

class CreateFollowSuccessState extends ProStates {}

class CreateFollowErrorState extends ProStates {
  final String error;

  CreateFollowErrorState(this.error);
}

class ProChangeBottomNavState extends ProStates {}

class ProProfileImagePickedSuccessState extends ProStates {}

class ProProfileImagePickedErrorState extends ProStates {}

class ProCoverImagePickedSuccessState extends ProStates {}

class ProCoverImagePickedErrorState extends ProStates {}

class ProUploadProfileImageSuccessState extends ProStates {}

class ProUploadProfileImageErrorState extends ProStates {}

class ProUploadCoverImageSuccessState extends ProStates {}

class ProUploadCoverImageErrorState extends ProStates {}

class ProUserUpdateLoadingState extends ProStates {}

class ProUserUpdateErrorState extends ProStates {
  final String error;

  ProUserUpdateErrorState(this.error);
}

class ProPostImagePickedSuccessState extends ProStates {}

class ProPostImagePickedErrorState extends ProStates {}

class ProRemovePostImageState extends ProStates {}

class GetCategoriesLoadingState extends ProStates {}

class GetCategoriesSuccessState extends ProStates {}

class GetCategoriesErrorState extends ProStates {
  final String error;

  GetCategoriesErrorState(this.error);
}

class GetPractsLoadingState extends ProStates {}

class GetPractsSuccessState extends ProStates {}

class GetPractsErrorState extends ProStates {
  final String error;

  GetPractsErrorState(this.error);
}

class FollowSuccessState extends ProStates {}

class UnFollowSuccessState extends ProStates {}

class ChangeRatingState extends ProStates {}

class SendMessageSuccessState extends ProStates {}

class SendMessageErrorState extends ProStates {}

class GetMessagesSuccessState extends ProStates {}
