// ignore_for_file: constant_identifier_names

import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layout/pro_app/cubit/cubit.dart';
import '../../models/pro_app/practitioner.dart';
import '../../modules/pro_app/categories/1.plumber_screen.dart';
import '../../modules/pro_app/categories/10.washer_screen.dart';
import '../../modules/pro_app/categories/2.mechanical_screen.dart';
import '../../modules/pro_app/categories/3.carpenter_screen.dart';
import '../../modules/pro_app/categories/4.electricain_screen.dart';
import '../../modules/pro_app/categories/5.welder_screen.dart';
import '../../modules/pro_app/categories/6.barber_screen.dart';
import '../../modules/pro_app/categories/7.cleaner_screen.dart';
import '../../modules/pro_app/categories/8.Chef_screen.dart';
import '../../modules/pro_app/profile/profile.dart';
import '../cubit/cubit.dart';
import '../styles/colors.dart';
import '../styles/icon_broken.dart';

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          IconBroken.Arrow___Left_2,
        ),
      ),
      titleSpacing: 5.0,
      title: Text(
        title!,
      ),
      actions: actions,
    );
TextFormField buildFixedTextField(
    {text, intial, required Icon icon, int? max}) {
  return TextFormField(
    enabled: false,
    decoration: InputDecoration(
      labelText: text,
      icon: icon,
      labelStyle: TextStyle(fontSize: 20),
    ),
    readOnly: true,
    initialValue: "$intial",
    style: TextStyle(fontSize: 18),
    maxLines: max ?? 1,
  );
}

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  required Function() function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        Function? onSubmit,
        Function? onChange,
        Function? onTap,
        bool isPassword = false,
        required Function(String? val) validate,
        required String label,
        required IconData prefix,
        IconData? suffix,
        Function()? suffixPressed,
        bool isClickable = true,
        int? hint}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (_) => onSubmit,
      onChanged: (_) => onChange,
      onTap: () => onTap,
      validator: (val) => validate(val),
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffix,
                  ),
                )
              : null,
          border: const OutlineInputBorder(),
          hintMaxLines: hint),
    );

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(
                '${model['time']}',
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'done',
                  id: model['id'],
                );
              },
              icon: const Icon(
                Icons.check_box,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateData(
                  status: 'archive',
                  id: model['id'],
                );
              },
              icon: const Icon(
                Icons.archive,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(
          id: model['id'],
        );
      },
    );

Widget tasksBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilderRec(
      condition: tasks.isNotEmpty,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) {
          return buildTaskItem(tasks[index], context);
        },
        separatorBuilder: (context, index) => myDivider(),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

void MyshowToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

void showToastNew(context, text) => showToast(
      text,
      backgroundColor: Colors.red,
      borderRadius: BorderRadius.circular(20),
      textStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: const StyledToastPosition(
        align: Alignment.bottomCenter,
        offset: 10,
      ),
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

SingleChildScrollView buildPracts(
    cotext,
    imageUrl,
    fullName,
    evaluation,
    status,
    phoneNumber,
    description,
    email,
    experience,
    Id,
    List<Practitioner> list) {
  return SingleChildScrollView(
    child: InkWell(
      onTap: () => selectPract(cotext, imageUrl, fullName, evaluation, status,
          phoneNumber, description, email, experience, Id, list),
      child: Stack(
        alignment: Alignment(0.9, -0.7),
        children: [
          Expanded(
            child: Card(
              color: Colors.white,
              shadowColor: Colors.black,
              margin: const EdgeInsets.all(10),
              elevation: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl!),
                    radius: 60,
                  ),
                  const SizedBox(width: 70),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullName!,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      buidRow(
                        evaluation!,
                        const Icon(Icons.sentiment_satisfied,
                            size: 40, color: Colors.orange),
                      ),
                      buidRow(
                        status!,
                        Icon(Icons.schedule,
                            size: 40,
                            color:
                                status == "busy" ? Colors.red : Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor:
                ProCubit.get(cotext).isFollow(Id) ? defaultColor : Colors.green,
            child: IconButton(
              key: UniqueKey(),
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.favorite_border,
                size: 20.0,
                color: Colors.white,
              ),
              onPressed: () {
                ProCubit.get(cotext).followPract(Id);
              },
            ),
          ),
        ],
      ),
    ),
  );
}

Row buidRow(String text, Icon icon) {
  return Row(
    children: [
      icon,
      const SizedBox(width: 5),
      Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ],
  );
}

void selectPract(BuildContext ctx, imageUrl, fullName, evaluation, status,
    phoneNumber, description, email, experience, Id, List<Practitioner> list) {
  navigateTo(
    ctx,
    PractProfile(
      Id: Id,
      description: description,
      email: email,
      evaluation: evaluation,
      experience: experience,
      fullName: fullName,
      mageUrl: imageUrl,
      phoneNumber: phoneNumber,
      status: status,
      pract: list,
    ),
  );
}

List<Practitioner> followList = [];

void selectCategoryMain(BuildContext context, id, title) {
  switch (title) {
    case "Mechanical":
      navigateTo(
        context,
        MechanicalScreen(id: id, title: title),
      );
      break;
    case "Plumber":
      navigateTo(
        context,
        PlumberScreen(id: id, title: title),
      );
      break;
    case "Carpenter":
      navigateTo(
        context,
        CarpenterScreen(id: id, title: title),
      );
      break;
    case "Electricain":
      navigateTo(
        context,
        ElectricainScreen(id: id, title: title),
      );
      break;
    case "Welder":
      navigateTo(
        context,
        WelderScreen(id: id, title: title),
      );
      break;
    case "Barber":
      navigateTo(
        context,
        BarberScreen(id: id, title: title),
      );
      break;
    case "Cleaner":
      navigateTo(
        context,
        CleanerScreen(id: id, title: title),
      );
      break;
    case "Chef":
      navigateTo(
        context,
        ChefScreen(id: id, title: title),
      );
      break;
    case "Washer Cars":
      navigateTo(
        context,
        WasherCarsScreen(id: id, title: title),
      );
      break;
    case "Repairer":
      navigateTo(
        context,
        MechanicalScreen(id: id, title: title),
      );
      break;
  }
}
