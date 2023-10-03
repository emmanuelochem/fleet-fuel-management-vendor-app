import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/shared/widgets/actionable_option_list_tile.dart';
import 'package:ceuk_user_app/shared/widgets/general_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.secondary600,
      appBar: const GeneralAppBar(
        title: 'Support Centre',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 0.058.sw,
          right: 0.058.sw,
          top: 0.006.sh,
          bottom: 0.016.sh,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Contact Us',
            //   style: TypographyStyle.bodyMediumn.copyWith(
            //     height: 1,
            //     //fontSize: fontSize,
            //     color: UIColors.secondary300,
            //   ),
            // ),
            SizedBox(
              height: 0.019.sh,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // GestureDetector(
                  //   onTap: (() async {
                  //     // GeneralLogics.launchURL('https://tyms.africa/help');
                  //   }),
                  //   child: ActionableOptionListTile(
                  //     title: 'Knowledge Base (Help)',
                  //     backgroundColor: UIColors.white,
                  //     fontSize: 16.sp,
                  //     iconBackgroundColor: UIColors.secondary500,
                  //     iconData: PhosphorIcons.question,
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: (() {
                      // final Uri _phoneLaunchUri =
                      //     Uri(scheme: 'tel', path: '+2347002566663');
                      // GeneralLogics.openExternalLink(_phoneLaunchUri);
                      GeneralLogics.launchURL('tel:+23470025666639');
                    }),
                    child: ActionableOptionListTile(
                      title: 'Call us (8am to 7pm - Mon to Fri)',
                      backgroundColor: UIColors.white,
                      fontSize: 16.sp,
                      iconBackgroundColor: UIColors.secondary500,
                      iconData: PhosphorIcons.phone_call,
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      final Uri emailLaunchUri =
                          Uri(scheme: 'mailto', path: 'contact@tyms.africa');

                      _launchURL(emailLaunchUri.toString());
                    }),
                    child: ActionableOptionListTile(
                      title: 'Send us an email (24/7)',
                      backgroundColor: UIColors.white,
                      fontSize: 16.sp,
                      iconBackgroundColor: UIColors.secondary500,
                      iconData: PhosphorIcons.envelope,
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: (() {
                  //     // GeneralLogics.launchURL(
                  //     //     'https://bit.ly/ajomoney-nike-whatsapp');
                  //   }),
                  //   child: ActionableOptionListTile(
                  //     title: 'WhatsApp (8am to 5pm - Mon to Fri)',
                  //     backgroundColor: UIColors.white,
                  //     fontSize: 16.sp,
                  //     iconBackgroundColor: UIColors.secondary500,
                  //     iconData: PhosphorIcons.whatsapp_logo,
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: (() {
                  //     // GeneralLogics.launchURL(
                  //     //     'https://instagram.com/tymsafrica');
                  //   }),
                  //   child: ActionableOptionListTile(
                  //     title: 'Instagram',
                  //     backgroundColor: UIColors.white,
                  //     fontSize: 16.sp,
                  //     iconBackgroundColor: UIColors.secondary500,
                  //     iconData: PhosphorIcons.instagram_logo,
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: (() {
                      GeneralLogics.launchURL(
                          'https://twitter.com/ceucenergiesltd');
                    }),
                    child: ActionableOptionListTile(
                      title: 'Twitter',
                      backgroundColor: UIColors.white,
                      fontSize: 16.sp,
                      iconBackgroundColor: UIColors.secondary500,
                      iconData: PhosphorIcons.twitter_logo,
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: (() {
                  //     // GeneralLogics.launchURL(
                  //     //     'https://facebook.com/tymsafrica');
                  //   }),
                  //   child: ActionableOptionListTile(
                  //     title: 'Facebook',
                  //     backgroundColor: UIColors.white,
                  //     fontSize: 16.sp,
                  //     iconBackgroundColor: UIColors.secondary500,
                  //     iconData: PhosphorIcons.facebook_logo,
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: (() {
                  //     // GeneralLogics.launchURL(
                  //     //     'https://linkedin.com/company/tymsafrica');
                  //   }),
                  //   child: ActionableOptionListTile(
                  //     title: 'LinkedIn',
                  //     backgroundColor: UIColors.white,
                  //     fontSize: 16.sp,
                  //     iconBackgroundColor: UIColors.secondary500,
                  //     iconData: PhosphorIcons.linkedin_logo,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
