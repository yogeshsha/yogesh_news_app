import 'package:flutter/material.dart';
import 'package:newsapp/presentation/screens/home/component/selected_component.dart';
import 'package:newsapp/utils/app.dart';
import '../../../../data/category_data/domain/category_model/news_category_model.dart';

class CategoryComponent extends StatelessWidget {
  final List<NewsCategoryModel> categoryList;
  final List<int> selectedCategoryList;
  final Function(int) onRemoveList;
  final Function(int) onAddCategory;
  final Function onTapAll;
  final EdgeInsets? margin;

  const CategoryComponent(
      {super.key,
      required this.categoryList,
      required this.selectedCategoryList,
      required this.onRemoveList,
      required this.onAddCategory,
      required this.onTapAll, this.margin});

  @override
  Widget build(BuildContext context) {
    if (categoryList.isNotEmpty) {
      double width = MediaQuery.of(context).size.width;

      return Container(
        margin:margin ?? EdgeInsets.zero,
        height: 65,
        width: width,
        child: ListView.builder(
            primary: false,
            itemCount: categoryList.length,
            padding: const EdgeInsets.only(left: 0,top: 15,bottom: 10),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              NewsCategoryModel model = categoryList[index];
              int id = model.id ?? 0;
              String name = AppHelper.getHindiEnglishText(model.name , model.hindiName);
              bool isSelected = selectedCategoryList.contains(id);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SelectedComponent(
                  alignment: Alignment.center,
                    title: name,
                    onTap: () {
                      if (isSelected) {
                        onRemoveList(id);
                      } else {
                        if (id == -1) {
                          onTapAll();
                        } else {
                          onAddCategory(id);
                        }
                      }
                    },
                    isSelected: isSelected),
              );
            }),
      );
    }
    return const SizedBox();
  }
}
