// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../layout/pro_app/cubit/cubit.dart';
import '../../../layout/pro_app/cubit/states.dart';
import '../../../models/pro_app/practitioner.dart';
import '../../../shared/components/components.dart';

// ignore: must_be_immutable
class PractProfile extends StatelessWidget {
  String? mageUrl;
  String? fullName;
  String? evaluation;
  String? status;
  String? phoneNumber;
  String? description;
  String? email;
  int? experience;
  int? Id;

  List<Practitioner> pract;
  PractProfile(
      {Key? key,
      required this.mageUrl,
      required this.fullName,
      required this.evaluation,
      required this.status,
      required this.phoneNumber,
      required this.description,
      required this.email,
      required this.experience,
      required this.Id,
      required this.pract})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProCubit, ProStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      color: Color.fromARGB(255, 14, 16, 111),
                      child: Column(
                        children: [
                          Container(
                            height: 150.0,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                CircleAvatar(
                                  radius: 64.0,
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: NetworkImage(
                                      '${mageUrl}',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            '${fullName}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  buildShowRating(context);
                                },
                                icon: Image.asset(
                                  'assets/images/review.png',
                                  width: 40,
                                  height: 30,
                                  color: Colors.white,
                                ),
                                label: Text("Rating"),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  launchUrlString("tel:$phoneNumber");
                                },
                                icon: Icon(Icons.call),
                                label: Text("Call"),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Evaluation',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                      ),
                                      Text(
                                        '$evaluation',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                                fontSize: 18,
                                                color: Colors.yellow,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Status',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                      ),
                                      Text(
                                        '$status',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                              fontSize: 18,
                                              color: status == "Busy"
                                                  ? Colors.red
                                                  : Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Experience',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                      ),
                                      Text(
                                        '$experience',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                                fontSize: 22,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          buildFixedTextField(
                            text: "PhoneNumber",
                            intial: '$phoneNumber',
                            icon: Icon(Icons.phone),
                          ),
                          buildFixedTextField(
                            text: "Email",
                            intial: '$email',
                            icon: Icon(Icons.email),
                          ),
                          buildFixedTextField(
                            text: "Description",
                            intial: '$description',
                            icon: Icon(Icons.description),
                            max: 5,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  buildShowRating(context) {
    showDialog(
        context: context,
        builder: (context) => BlocConsumer<ProCubit, ProStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return AlertDialog(
                title: Text("Rate this Practitioner"),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Please Leave a star rating ",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 32),
                    buildRating(context),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Ok ",
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            }));
  }

  Container buildRating(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Rating: ${ProCubit.get(context).rating}",
            style: TextStyle(
              fontSize: 30,
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 32),
          RatingBar.builder(
              itemPadding: EdgeInsets.symmetric(horizontal: 4),
              updateOnDrag: true,
              itemSize: 40,
              minRating: 1,
              itemBuilder: (context, _) =>
                  Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                ProCubit.get(context).changeRating(rating);
              }),
        ],
      ),
    );
  }
}
