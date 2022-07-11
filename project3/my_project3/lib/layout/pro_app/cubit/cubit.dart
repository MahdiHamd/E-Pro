import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/layout/pro_app/cubit/states.dart';

import '../../../models/pro_app/category.dart';
import '../../../models/pro_app/message_model.dart';
import '../../../models/pro_app/practitioner.dart';
import '../../../models/pro_app/pro_user_model.dart';
import '../../../modules/pro_app/categories/category_screen.dart';
import '../../../modules/pro_app/chats/chats_screen.dart';
import '../../../modules/pro_app/following/follow_screen.dart';
import '../../../modules/pro_app/settings/settings_screen.dart';
import '../../../shared/components/constants.dart';

class ProCubit extends Cubit<ProStates> {
  ProCubit() : super(ProInitialState());

  static ProCubit get(context) => BlocProvider.of(context);

  ProUserModel? userModel;

  void getUserData() async {
    emit(ProGetUserLoadingState());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      //print(value.data());
      userModel = ProUserModel.fromJson(value.data()!);
      emit(ProGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ProGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    CategoryList(),
    ChatsScreen(),
    FollowScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Following',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 1) getUsers();

    currentIndex = index;
    emit(ProChangeBottomNavState());
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(ProProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ProProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(ProCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ProCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(ProUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(
          name: name,
          phone: phone,
          email: email,
          image: value,
        );
      }).catchError((error) {
        emit(ProUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(ProUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(ProUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(ProUploadCoverImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          email: email,
          cover: value,
        );
      }).catchError((error) {
        emit(ProUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(ProUploadCoverImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String email,
    String? cover,
    String? image,
  }) {
    ProUserModel model = ProUserModel(
      name: name,
      phone: phone,
      email: email,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(ProUserUpdateErrorState(error.toString()));
    });
  }

  List<ProUserModel> users = [];

  void getUsers() {
    emit(ProGetAllUsersLoadingState());
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != userModel!.uId)
            users.add(ProUserModel.fromJson(element.data()));
        });

        emit(ProGetAllUsersSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(ProGetAllUsersErrorState(error.toString()));
      });
  }

  List<MyCategories> categories = [];

  void getCategories() {
    emit(GetCategoriesLoadingState());
    FirebaseFirestore.instance.collection('types').get().then((value) {
      value.docs.forEach((element) {
        categories.add(MyCategories.fromJson(element.data()));
      });
      emit(GetCategoriesSuccessState());
    }).catchError((error) {
      emit(GetCategoriesErrorState(error.toString()));
    });
  }

  List<Practitioner> practitioners = [];

  void getPracts() {
    emit(GetPractsLoadingState());

    FirebaseFirestore.instance.collection('pro').get().then((value) {
      print(value.docs[0]["name"]);
      print("hi");
      value.docs.forEach((doc) {
        practitioners.add(Practitioner.fromJson(doc.data()));
      });

      print('practitioners = ${practitioners[0].email}');
      emit(GetPractsSuccessState());
    }).catchError((error) {
      emit(GetPractsErrorState(error.toString()));
    });
  }

  // List<Practitioner> practitioners2 = [];

  // String getPracts2(PracId) {
  //   String docId = "";
  //   emit(GetPractsLoadingState());
  //   FirebaseFirestore.instance.collection('pro').get().then((value) {
  //     for (var i = 0; i < value.size; i++) {
  //       print('nimber of parct: ${value.size}');
  //       if (value.docs[i]["id"] == PracId) {
  //         docId = value.docs[i].id;
  //         print(docId);
  //       }
  //     }
  //   });

  //   return docId;
  // }

  List<Practitioner> followList = [];
  void followPract(PractId) {
    final existIndex = followList.indexWhere((pract) => pract.id == PractId);
    if (existIndex >= 0) {
      followList.removeAt(existIndex);
    } else {
      followList.add(practitioners.firstWhere((pract) => pract.id == PractId));
    }

    emit(FollowSuccessState());
  }

  bool isFollow(PractId) {
    return followList.any((pract) => pract.id == PractId);
  }

  double rating = 0;
  changeRating(Newrating) {
    rating = Newrating;
    emit(ChangeRatingState());
  }

  void sendMessage({
    required String receiverId,
    required String dataTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      senderId: userModel!.uId,
      receiverId: receiverId,
      dataTime: dataTime,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dataTime')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(GetMessagesSuccessState());
    });
  }
}
