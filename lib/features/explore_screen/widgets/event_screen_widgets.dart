import 'package:all_events_practical/features/explore_screen/explore_bloc.dart';
import 'package:all_events_practical/features/explore_screen/widgets/category_data_bottom_sheet.dart';
import 'package:all_events_practical/features/webview_screen.dart';
import 'package:all_events_practical/model/category_event_model.dart';
import 'package:flutter/material.dart';

class EventScreenTopWidget extends StatelessWidget {
  final ExploreBloc exploreBloc;
  final int selectedIndex;
  final AnimationController animationController;

  const EventScreenTopWidget(
      {super.key,
      required this.exploreBloc,
      required this.selectedIndex,
      required this.animationController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                CategoryDataBottomSheet.showCategoryDataInSheet(
                    context: context,
                    exploreBloc: exploreBloc,
                    selectedIndex: selectedIndex,
                    animationController: animationController);
              },
              child: StreamBuilder<String>(
                  stream: exploreBloc.getSelectedCategoryNameStream,
                  builder: (context, snapshot) {
                    String selectedCategoryName =
                        snapshot.hasData && snapshot.data != null
                            ? snapshot.data ?? "all"
                            : "";
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.celebration,
                          size: 20,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 2.0,
                        ),
                        Text(
                          selectedCategoryName.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    );
                  })),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_month,
                size: 20,
                color: Colors.grey,
              ),
              SizedBox(
                width: 2.0,
              ),
              Text(
                "Date & Time",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.sort,
                size: 20,
                color: Colors.grey,
              ),
              SizedBox(
                width: 2.0,
              ),
              Text(
                "Sort",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EventListWidget extends StatelessWidget {
  final List<Item> itemList;
  final int index;

  const EventListWidget(
      {super.key, required this.itemList, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        WebviewDialog.webview(
            context: context, url: itemList[index].eventUrl ?? "");
      },
      child: Container(
        padding: const EdgeInsets.all(15.0),
        margin: EdgeInsets.only(
            top: 15.0, bottom: index == ((itemList.length) - 1) ? 20 : 0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                itemList[index].thumbUrlLarge ?? "",
                width: 80,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemList[index].eventname ?? "",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(itemList[index].label ?? ""),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                        "${itemList[index].venue!.city}, ${itemList[index].venue!.state}"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
