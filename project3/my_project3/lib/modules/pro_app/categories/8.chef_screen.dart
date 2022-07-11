import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/pro_app/cubit/cubit.dart';
import '../../../layout/pro_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class ChefScreen extends StatelessWidget {
  final title;
  final id;
  const ChefScreen({Key? key, this.title, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProCubit, ProStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var practs = ProCubit.get(context).practitioners;

        var practsChef = ProCubit.get(context)
            .practitioners
            .where(
              (element) => element.categoriesId == id,
            )
            .toList();

        return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: ListView.builder(
              itemCount: practsChef.length,
              itemBuilder: (context, index) {
                return buildPracts(
                  context,
                  practsChef[index].picture,
                  practsChef[index].name,
                  practsChef[index].evaluation,
                  practsChef[index].status,
                  practsChef[index].phone,
                  practsChef[index].description,
                  practsChef[index].email,
                  practsChef[index].experience,
                  practsChef[index].id,
                  practs
                );
              },
            ));
      },
    );
  }
}
