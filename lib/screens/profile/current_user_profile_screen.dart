import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:traveling_social_app/constants/app_theme_constants.dart';
import 'package:traveling_social_app/models/User.dart';
import 'package:traveling_social_app/screens/create_story/create_story_screen.dart';
import 'package:traveling_social_app/screens/home/home_screen.dart';
import 'package:traveling_social_app/screens/profile/components/background.dart';
import 'package:traveling_social_app/screens/profile/components/follow_count.dart';
import 'package:traveling_social_app/screens/story/story_card.dart';
import 'package:traveling_social_app/utilities/application_utility.dart';
import 'package:traveling_social_app/view_model/user_viewmodel.dart';
import 'package:traveling_social_app/widgets/user_avt.dart';
import 'components/button_edit_profile.dart';
import 'components/title_with_number.dart';
import 'package:provider/provider.dart';

class CurrentUserProfileScreen extends StatefulWidget {
  const CurrentUserProfileScreen({Key? key}) : super(key: key);

  @override
  _CurrentUserProfileScreenState createState() =>
      _CurrentUserProfileScreenState();
}

class _CurrentUserProfileScreenState extends State<CurrentUserProfileScreen> {
  bool _isLoading = false;

  _handleButtonCreatePostClicked(Size size) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            onPressed: () {}, child: Text('Create post'))),
                    SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              ApplicationUtility.navigateToScreen(
                                  context, const CreateStoryScreen());
                            },
                            child: Text('Create story')))
                  ],
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child:
                      Text("Cancel", style: TextStyle(color: Colors.red[300])),
                ),
              )
            ],
          ),
        );
      },
      backgroundColor: Colors.transparent,
    );
  }

  late UserViewModel _userViewModel;

  @override
  void initState() {
    super.initState();
    _userViewModel = context.read<UserViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            //APPBAR
            SliverAppBar(
              centerTitle: true,
              title: Text(
                _userViewModel.user!.username.toString(),
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black45,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size(double.infinity, 1),
                child: Divider(
                  color: kPrimaryColor.withOpacity(.2),
                  height: 1,
                ),
              ),
              backgroundColor: Colors.white,
              // title: Text('Traveling Crew',style: TextStyle(color: Colors.black,fontSize: 20),),
              floating: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/icons/search.svg",
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                    onPressed: () => _handleButtonCreatePostClicked(size),
                    icon: const Icon(Icons.edit, color: Colors.black45)),
                const SizedBox(
                  width: 5,
                ),
              ],
              // expandedHeight: 250,
            ),
            //BODY
            SliverToBoxAdapter(
              child: CurrentUserProfileBackground(
                isLoading: _isLoading,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          //AVT
                          SizedBox(
                            height: size.height * .4,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                Container(
                                  height: (size.height * .4) - 50,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/home_bg.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Container(
                                    height: double.infinity,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            TitleWithNumber(
                                                title: "Follower", number: 100),
                                            TitleWithNumber(
                                                title: "Following", number: 12),
                                          ],
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: kDefaultPadding / 2,
                                          child: Row(
                                            children: const [
                                              Icon(
                                                IconData(0xe3ab,
                                                    fontFamily:
                                                        "MaterialIcons"),
                                                color: Colors.white24,
                                              ),
                                              Text(
                                                "position",
                                                style: TextStyle(
                                                    color: Colors.white24),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                //CURRENT USER VATAR
                                Positioned(
                                  bottom: 0,
                                  left: kDefaultPadding,
                                  child: Selector<UserViewModel, User>(
                                    selector: (p0, p1) => p1.user!,
                                    builder: (context, value, child) =>
                                        UserAvatar(
                                      user: value,
                                      size: 150,
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: kDefaultPadding / 2,
                                  child: Container(
                                    constraints:
                                        const BoxConstraints(minWidth: 130),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    height: 40,
                                    child: const ButtonEditProfile(),
                                  ),
                                )

                                // return SizedBox.shrink();
                                // })
                              ],
                            ),
                          ),
                          //STORIES

                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //FULL NAME
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Selector<UserViewModel, String>(
                                      builder: (BuildContext context, value,
                                          Widget? child) =>
                                          const Text(
                                            'Nguyen Khanh Duy',
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                      selector: (p0, p1) =>
                                          p1.user!.username.toString(),
                                    ),
                                  ),
                                  //USERNAME
                                  Selector<UserViewModel, String>(
                                    builder: (BuildContext context, value,
                                            Widget? child) =>
                                        Text(
                                      '@$value',
                                      style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 15),
                                    ),
                                    selector: (p0, p1) =>
                                        p1.user!.username.toString(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Selector<UserViewModel, int?>(
                                          builder: (BuildContext context, value,
                                                  Widget? child) =>
                                              FollowCount(
                                                  title: "Following",
                                                  count: value.toString()),
                                          selector: (p0, p1) =>
                                              p1.user!.followingCounts,
                                        ),
                                        Selector<UserViewModel, int?>(
                                          builder: (BuildContext context, value,
                                                  Widget? child) =>
                                              FollowCount(
                                                  title: "Follower",
                                                  count: value.toString()),
                                          selector: (p0, p1) =>
                                              p1.user!.followerCounts,
                                        ),
                                      ],
                                    ),
                                  )
                                  //
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: kPrimaryColor,
          ),
          child: IconButton(
            onPressed: () => Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 500),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const HomeScreen();
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = const Offset(0.0, 1.0);
                  var end = Offset.zero;
                  var tween = Tween(begin: begin, end: end);
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            ),
            icon: const Icon(Icons.chat, color: Colors.white),
          ),
        ),
      ),
    );
  }
}