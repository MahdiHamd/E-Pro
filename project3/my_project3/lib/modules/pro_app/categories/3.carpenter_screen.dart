import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/pro_app/cubit/cubit.dart';
import '../../../layout/pro_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class CarpenterScreen extends StatelessWidget {
  final title;
  final id;
  const CarpenterScreen({Key? key, this.title, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProCubit, ProStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var practs = ProCubit.get(context).practitioners;

        var practsCarpenter = ProCubit.get(context)
            .practitioners
            .where(
              (element) => element.categoriesId == id,
            )
            .toList();

        return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: ListView.builder(
              itemCount: practsCarpenter.length,
              itemBuilder: (context, index) {
                return buildPracts(
                  context,
                  practsCarpenter[index].picture,
                  practsCarpenter[index].name,
                  practsCarpenter[index].evaluation,
                  practsCarpenter[index].status,
                  practsCarpenter[index].phone,
                  practsCarpenter[index].description,
                  practsCarpenter[index].email,
                  practsCarpenter[index].experience,
                  practsCarpenter[index].id,
                  practs
                );
              },
            ));
      },
    );
  }
}
