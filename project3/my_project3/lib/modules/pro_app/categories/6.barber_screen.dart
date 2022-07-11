import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/pro_app/cubit/cubit.dart';
import '../../../layout/pro_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class BarberScreen extends StatelessWidget {
  final title;
  final id;
  const BarberScreen({Key? key, this.title, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProCubit, ProStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var practs = ProCubit.get(context).practitioners;

        var practsBarber = ProCubit.get(context)
            .practitioners
            .where(
              (element) => element.categoriesId == id,
            )
            .toList();

        return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: ListView.builder(
              itemCount: practsBarber.length,
              itemBuilder: (context, index) {
                return buildPracts(
                  context,
                  practsBarber[index].picture,
                  practsBarber[index].name,
                  practsBarber[index].evaluation,
                  practsBarber[index].status,
                  practsBarber[index].phone,
                  practsBarber[index].description,
                  practsBarber[index].email,
                  practsBarber[index].experience,
                  practsBarber[index].id,
                  practs
                );
              },
            ));
      },
    );
  }
}
