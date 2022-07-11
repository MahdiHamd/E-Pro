import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/pro_app/cubit/cubit.dart';
import '../../../layout/pro_app/cubit/states.dart';
import '../../../shared/components/components.dart';

class FollowScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProCubit, ProStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var follow = ProCubit.get(context).followList;
        return ListView.builder(
          itemCount: follow.length,
          itemBuilder: (context, index) {
            return buildPracts(
              context,
              follow[index].picture,
              follow[index].name,
              follow[index].evaluation,
              follow[index].status,
              follow[index].phone,
              follow[index].description,
              follow[index].email,
              follow[index].experience,
              follow[index].id,
              follow,
            );
          },
        );
      },
    );
  }
}
