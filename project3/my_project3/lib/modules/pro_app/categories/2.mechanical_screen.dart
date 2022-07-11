import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/pro_app/cubit/cubit.dart';
import '../../../layout/pro_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class MechanicalScreen extends StatelessWidget {
  final title;
  final id;
  const MechanicalScreen({Key? key, this.title, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProCubit, ProStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var practs = ProCubit.get(context).practitioners;

        var practsMechanical = ProCubit.get(context)
            .practitioners
            .where(
              (element) => element.categoriesId == id,
            )
            .toList();

        return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: ListView.builder(
              itemCount: practsMechanical.length,
              itemBuilder: (context, index) {
                return buildPracts(
                    context,
                    practsMechanical[index].picture,
                    practsMechanical[index].name,
                    practsMechanical[index].evaluation,
                    practsMechanical[index].status,
                    practsMechanical[index].phone,
                    practsMechanical[index].description,
                    practsMechanical[index].email,
                    practsMechanical[index].experience,
                    practsMechanical[index].id,
                    practs);
              },
            ));
      },
    );
  }
}
