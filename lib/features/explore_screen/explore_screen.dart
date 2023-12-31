import 'package:all_events_practical/features/authentication_screen/login_screen.dart';
import 'package:all_events_practical/features/explore_screen/explore_bloc.dart';
import 'package:all_events_practical/features/explore_screen/widgets/event_screen_widgets.dart';
import 'package:all_events_practical/model/category_event_model.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  final ExploreBloc exploreBloc = ExploreBloc();

  int selectedIndex = -1; // Track the index of the selected item

  bool isListView = false;

  @override
  void initState() {
    super.initState();
    animationController = BottomSheet.createAnimationController(this);
    animationController.duration = const Duration(milliseconds: 500);

    exploreBloc.getCategoryData();
    exploreBloc.getEventDataByCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: exploreBloc.eventSearchController,
            onChanged: (query) {
              exploreBloc.onSearch(query);
            },
            decoration: const InputDecoration(
                hintText: 'Search Events',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                focusColor: Colors.transparent),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Toggle button
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Grid View'),
                  Switch(
                    activeColor: Colors.blue,
                    value: isListView,
                    onChanged: (value) {
                      setState(() {
                        isListView = value;
                      });
                    },
                  ),
                  const Text('List View'),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      handleLogOut(context: context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              //Top widget
              EventScreenTopWidget(
                  exploreBloc: exploreBloc,
                  selectedIndex: selectedIndex,
                  animationController: animationController),
              //event list data
              StreamBuilder<bool>(
                  stream: exploreBloc.isDataLoaded.stream,
                  builder: (context, snapshotLoader) {
                    return StreamBuilder(
                        stream: exploreBloc.getSearchEventListStream,
                        builder: (context, snapshot) {
                          if (snapshotLoader.hasData) {
                            if (snapshot.data!.isNotEmpty &&
                                snapshot.data != null) {
                              return isListView
                                  ? buildListView(snapshot.data!)
                                  : buildGridView(snapshot.data!);
                            } else {
                              return const Padding(
                                padding: EdgeInsets.only(top: 100),
                                child: Center(
                                  child: Text(
                                    "No data found",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            }
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            );
                          }
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListView(List<Item> itemList) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return EventListWidget(
              itemList: itemList,
              index: index,
            );
          }),
    );
  }

  Widget buildGridView(List<Item> itemList) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            mainAxisExtent: 300),
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          return EventListWidget(
            itemList: itemList,
            index: index,
          );
        },
      ),
    );
  }

  Future<void> handleLogOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await googleSignIn.signOut();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('user_name');
      prefs.remove('user_email');
      prefs.setBool('is_signed_in', false);

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text(
            'Logout successfully',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error signing out. Try again.'),
        ),
      );
    }
  }
}
