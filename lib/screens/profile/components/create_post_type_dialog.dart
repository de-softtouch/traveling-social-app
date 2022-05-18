import 'package:flutter/material.dart';
import 'package:traveling_social_app/widgets/my_divider.dart';

import '../../../utilities/application_utility.dart';
import '../../create_post/create_post_screen.dart';
import '../../create_story/create_story_screen.dart';

class CreatePostTypeDialog extends StatelessWidget {
  const CreatePostTypeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BottomModelItem(
                    title: 'Create post',
                    onClick: () {
                      Navigator.of(context).pop();
                      ApplicationUtility.navigateToScreen(
                          context, const CreatePostScreen());
                    }),
                const SizedBox(child: MyDivider()),
                BottomModelItem(
                    title: 'Create story',
                    onClick: () {
                      Navigator.of(context).pop();
                      ApplicationUtility.navigateToScreen(
                          context, const CreateStoryScreen());
                    })
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            child: BottomModelItem(title: "Cancel", onClick: ()=> Navigator.of(context).pop(),color: Colors.redAccent,)
          )
        ],
      ),
    );
  }
}

class BottomModelItem extends StatelessWidget {
  const BottomModelItem({Key? key, required this.title, required this.onClick, this.color})
      : super(key: key);

  final String title;
  final Function onClick;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () => onClick(),
        child: Text(
          title,
          style:  TextStyle(fontSize: 16, fontWeight: FontWeight.normal,color: color),
        ),
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          padding: const EdgeInsets.symmetric(vertical: 20),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
