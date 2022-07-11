import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/pro_app/cubit/cubit.dart';
import '../../../layout/pro_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class WasherCarsScreen extends StatelessWidget {
  final title;
  final id;
  const WasherCarsScreen({Key? key, this.title, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProCubit, ProStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var practs = ProCubit.get(context).practitioners;

        var practsWasher = ProCubit.get(context)
            .practitioners
            .where(
              (element) => element.categoriesId == id,
            )
            .toList();

        return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: ListView.builder(
              itemCount: practsWasher.length,
              itemBuilder: (context, index) {
                return buildPracts(
                  context,
                  practsWasher[index].picture,
                  practsWasher[index].name,
                  practsWasher[index].evaluation,
                  practsWasher[index].status,
                  practsWasher[index].phone,
                  practsWasher[index].description,
                  practsWasher[index].email,
                  practsWasher[index].experience,
                  practsWasher[index].id,
                  practs
                );
              },
            ));
      },
    );
  }
}
