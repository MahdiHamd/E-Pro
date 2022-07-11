import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/pro_app/cubit/cubit.dart';
import '../../../layout/pro_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class WelderScreen extends StatelessWidget {
  final title;
  final id;
  const WelderScreen({Key? key, this.title, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProCubit, ProStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var practs = ProCubit.get(context).practitioners;

        var practsWelder = ProCubit.get(context)
            .practitioners
            .where(
              (element) => element.categoriesId == id,
            )
            .toList();

        return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: ListView.builder(
              itemCount: practsWelder.length,
              itemBuilder: (context, index) {
                return buildPracts(
                  context,
                  practsWelder[index].picture,
                  practsWelder[index].name,
                  practsWelder[index].evaluation,
                  practsWelder[index].status,
                  practsWelder[index].phone,
                  practsWelder[index].description,
                  practsWelder[index].email,
                  practsWelder[index].experience,
                  practsWelder[index].id,
                  practs,
                );
              },
            ));
      },
    );
  }
}
