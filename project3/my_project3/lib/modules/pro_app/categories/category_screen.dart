import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/pro_app/cubit/cubit.dart';
import '../../../layout/pro_app/cubit/states.dart';
import '../../../models/pro_app/category.dart';
import '../../../shared/components/components.dart';


class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProCubit, ProStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<MyCategories> categories = ProCubit.get(context).categories;
        print(categories.length,);
        return ConditionalBuilderRec(
          condition: state is! GetCategoriesLoadingState,
          builder: (context) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      shadows: const <Shadow>[
                        Shadow(
                            color: Colors.black,
                            offset: Offset(1, 2), // can use nagative
                            blurRadius: 10),
                        Shadow(
                            color: Colors.deepOrange,
                            offset: Offset(2, 2), // can use nagative
                            blurRadius: 3),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  color: Colors.amber[50],
                  elevation: 15,
                  child: GridView(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 1/1.5,
                      maxCrossAxisExtent: 350,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    children: categories
                        .map((catData) => buildCategory(
                            context, catData.id, catData.name, catData.image))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

InkWell buildCategory(BuildContext context, id, title, image) {
  return InkWell(
    onTap: () => selectCategoryMain(context, id, title),
    borderRadius: BorderRadius.circular(18),
    child: Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(18),
              border: Border.all(width: 5, color: Colors.black),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            alignment: Alignment.center,
          ),
        )
      ],
    ),
  );
}

