import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traveling_social_app/models/User.dart';
import 'package:traveling_social_app/widgets/user_avt.dart';

import '../view_model/user_view_model.dart';

class CurrentUserAvt extends StatelessWidget {
  const CurrentUserAvt({Key? key, this.onTap,required this.size, this.margin}) : super(key: key);
  final Function? onTap;
  final double size;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Selector<UserViewModel, User?>(
      selector: (p0, p1) =>p1.user,
      builder: (context, value, child) => UserAvatar(
        margin: margin,
        user: value,
        size: size,
        onTap: onTap,
      ),
    );
  }
}
