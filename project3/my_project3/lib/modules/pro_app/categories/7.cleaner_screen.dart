import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/pro_app/cubit/cubit.dart';
import '../../../layout/pro_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class CleanerScreen extends StatelessWidget {
  final title;
  final id;
  const CleanerScreen({Key? key, this.title, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProCubit, ProStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var practs = ProCubit.get(context).practitioners;

        var practsCleaner = ProCubit.get(context)
            .practitioners
            .where(
              (element) => element.categoriesId == id,
            )
            .toList();

        return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: ListView.builder(
              itemCount: practsCleaner.length,
              itemBuilder: (context, index) {
                return buildPracts(
                  context,
                  practsCleaner[index].picture,
                  practsCleaner[index].name,
                  practsCleaner[index].evaluation,
                  practsCleaner[index].status,
                  practsCleaner[index].phone,
                  practsCleaner[index].description,
                  practsCleaner[index].email,
                  practsCleaner[index].experience,
                  practsCleaner[index].id,
                  practs
                );
              },
            ));
      },
    );
  }
}
