import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/image_strings.dart';
import 'drawer_elements_widget/drawer_item_widgets.dart';
import 'drawer_elements_widget/drawer_text_element.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: ekaAccentColor,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,

          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: ekaPrimaryColor),
              padding: EdgeInsets.zero,
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ekaBanner), fit: BoxFit.cover)),
              ),
            ),
            const TextElements(title: "Connect With Us"),
            DrawerItems(
              icon: Icons.library_music,
              text: 'Send Us Lyrics',
              onClick: () {},
            ),
            DrawerItems(
              icon: Icons.feedback,
              text: 'Feedback',
              onClick: () {},
            ),
            const TextElements(title: 'Policies'),
            DrawerItems(
              icon: Icons.privacy_tip,
              text: 'Privacy Policy',
              onClick: () {},
            ),
            DrawerItems(
              icon: Icons.notes,
              text: 'About',
              onClick: () {},
            ),
            DrawerItems(
              icon: Icons.share,
              text: 'Share App',
              onClick: () {},
            ),
            DrawerItems(
              icon: Icons.reviews,
              text: 'Rate and Review',
              onClick: () {},
            ),
          ],
        ));
  }
}
