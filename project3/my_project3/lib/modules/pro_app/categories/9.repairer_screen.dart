import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/layout/pro_app/cubit/states.dart';

import '../../../layout/pro_app/cubit/cubit.dart';
import '../../../shared/components/components.dart';

class RepairerScreen extends StatelessWidget {
  final title;
  final id;
  const RepairerScreen({Key? key, this.title, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProCubit, ProStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var practs = ProCubit.get(context).practitioners;

        var practsRepairer = ProCubit.get(context)
            .practitioners
            .where(
              (element) => element.categoriesId == id,
            )
            .toList();

        return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: ListView.builder(
              itemCount: practsRepairer.length,
              itemBuilder: (context, index) {
                return buildPracts(
                  context,
                  practsRepairer[index].picture,
                  practsRepairer[index].name,
                  practsRepairer[index].evaluation,
                  practsRepairer[index].status,
                  practsRepairer[index].phone,
                  practsRepairer[index].description,
                  practsRepairer[index].email,
                  practsRepairer[index].experience,
                  practsRepairer[index].id,
                  practs
                );
              },
            ));
      },
    );
  }
}
