import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/shared/components/components.dart';

import '../../../layout/pro_app/cubit/cubit.dart';
import '../../../layout/pro_app/cubit/states.dart';

class PlumberScreen extends StatelessWidget {
  final title;
  final id;
  const PlumberScreen({Key? key, this.title, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProCubit, ProStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var practs = ProCubit.get(context).practitioners;
        var practsPlumber = ProCubit.get(context)
            .practitioners
            .where(
              (element) => element.categoriesId == id,
            )
            .toList();

        return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: ListView.builder(
              itemCount: practsPlumber.length,
              itemBuilder: (context, index) {
                return buildPracts(
                  context,
                  practsPlumber[index].picture,
                  practsPlumber[index].name,
                  practsPlumber[index].evaluation,
                  practsPlumber[index].status,
                  practsPlumber[index].phone,
                  practsPlumber[index].description,
                  practsPlumber[index].email,
                  practsPlumber[index].experience,
                  practsPlumber[index].id,
                  practs
                );
              },
            ));
      },
    );
  }
}
