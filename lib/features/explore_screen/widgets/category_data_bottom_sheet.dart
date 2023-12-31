import 'package:all_events_practical/features/explore_screen/explore_bloc.dart';
import 'package:all_events_practical/model/category_model.dart';
import 'package:flutter/material.dart';

class CategoryDataBottomSheet {
  static showCategoryDataInSheet(
      {required BuildContext context,
      required ExploreBloc exploreBloc,
      required AnimationController animationController,
      required int selectedIndex}) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        context: context,
        transitionAnimationController: animationController,
        backgroundColor: Colors.white,
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewPadding.top),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      height: 4,
                      width: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: const Icon(Icons.close,
                              color: Colors.grey, size: 20),
                        )),
                  ),
                  const Text(
                    "Categories",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  StreamBuilder<List<CategoryModel>>(
                      stream: exploreBloc.getCategoryListStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData == true && snapshot.data != null) {
                          return Wrap(
                            spacing: 6.0,
                            runSpacing: 6.0,
                            children: List.generate(
                                snapshot.data!.length,
                                (index) => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          snapshot.data![index].isSelected =
                                              !snapshot.data![index].isSelected;

                                          // Update the selectedIndex to the currently tapped item
                                          selectedIndex = index;

                                          // Unselect all other items
                                          for (int i = 0;
                                              i < snapshot.data!.length;
                                              i++) {
                                            if (i != index) {
                                              snapshot.data![i].isSelected =
                                                  false;
                                            }
                                          }
                                        });

                                        exploreBloc.getEventDataByCategory(
                                            selectedCategory: snapshot
                                                    .data![index].category ??
                                                "");
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: snapshot.data![index]
                                                        .isSelected ==
                                                    true
                                                ? Colors.blue
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Text(
                                          snapshot.data![index].category!
                                              .toUpperCase(),
                                          style: const TextStyle(fontSize: 16),
                                        ), //Text
                                      ),
                                    )),
                          );
                        } else {
                          return const CircularProgressIndicator(
                            color: Colors.blue,
                          );
                        }
                      }),
                ],
              ),
            );
          });
        });
  }
}
