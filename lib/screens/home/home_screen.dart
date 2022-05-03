import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:traveling_social_app/constants/app_theme_constants.dart';
import 'package:traveling_social_app/models/User.dart';
import 'package:traveling_social_app/screens/home/components/drawer.dart';
import 'package:traveling_social_app/screens/home/components/home_body.dart';
import 'package:traveling_social_app/screens/login/login_screen.dart';
import 'package:traveling_social_app/screens/profile/current_user_profile_screen.dart';
import 'package:traveling_social_app/utilities/application_utility.dart';
import 'package:traveling_social_app/view_model/post_viewmodel.dart';
import 'package:traveling_social_app/view_model/user_viewmodel.dart';
import 'package:traveling_social_app/widgets/user_avt.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserViewModel _userViewModel;
  late User _user;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    ApplicationUtility.hideKeyboard();
    _userViewModel = context.read<UserViewModel>();
    if (_userViewModel.user == null) {
      ApplicationUtility.pushAndReplace(context, const LoginScreen());
    }
    PostViewModel postViewModel = context.read<PostViewModel>();
    if (postViewModel.stories.isEmpty) {
      postViewModel.fetchStories(page: 0, pageSize: 5);
    }
    _user = _userViewModel.user!;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: HomeDrawer(user: _user),
      body: Builder(
        builder: (context) => CustomScrollView(
          slivers: [
            //APP BAR
            SliverAppBar(
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
              leading: IconButton(
                focusColor: kPrimaryColor,
                hoverColor: kPrimaryColor,
                icon: SvgPicture.asset("assets/icons/menu.svg",
                    color: Colors.black),
                color: Colors.black,
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/icons/search.svg",
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Consumer<UserViewModel>(
                    builder: (context, value, child) => UserAvatar(
                      size: 25,
                      user: _user,
                      onTap: () => ApplicationUtility.navigateToScreen(
                          context, const CurrentUserProfileScreen()),
                    ),
                  ),
                )
              ],
              // expandedHeight: 250,
            ),
            //  END OF APP BAR
            const SliverToBoxAdapter(
              child: HomeBody(),
            ),
          ],
        ),
      ),
    );
  }
}