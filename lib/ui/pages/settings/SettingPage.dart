import 'package:Oukami/config/Config.dart';
import 'package:Oukami/ui/pages/settings/ItemCard.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:system_setting/system_setting.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPage1State createState() => _SettingPage1State();
}

class _SettingPage1State extends State<SettingPage> {
  Widget _arrow() {
    return Icon(
      Icons.arrow_forward_ios,
      color: BaseColor,
      size: 20.0,
    );
  }

  lauchEmail() {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'yanuarbimantoro@gmail.com',
        queryParameters: {'subject': 'Mangabuzz App'});

    launch(_emailLaunchUri.toString());
  }

  lauchUrl() async {
    const url = 'https://github.com/FlawLessx/mangabuzz/releases';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void onChatSettingChange(bool data) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        backgroundColor: BaseColor,
        shadowColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(top: 3),
              child: Text(
                'Settings',
                style: GoogleFonts.heebo(
                    fontSize: 24, fontWeight: FontWeight.w700, color: BGColor),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: (brightness == Brightness.light)
            ? Color(0xFFF7F7F7)
            : Color(0xFF000000),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                color: (brightness == Brightness.light)
                    ? Color(0xFFF7F7F7)
                    : Color(0xFF000000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Main',
                        style: GoogleFonts.heebo(
                            fontSize: 22,
                            height: 1.5,
                            fontWeight: FontWeight.w700,
                            color: BaseColor),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ItemCard(
                      title: 'Block ad',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                      callback: () {
                        lauchUrl();
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Settings',
                        style: GoogleFonts.heebo(
                            fontSize: 22,
                            height: 1.5,
                            fontWeight: FontWeight.w700,
                            color: BaseColor),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ItemCard(
                      title: 'Contact me',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: null,
                      callback: () {
                        lauchEmail();
                      },
                    ),
                    ItemCard(
                      title: 'Licences',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                      textColor: GreenColor,
                      callback: () {
                        showLicensePage(
                            context: context,
                            applicationName: 'Oukami',
                            applicationVersion: 'v1.0.0',
                            useRootNavigator: true,
                            applicationIcon: Image.asset(
                                'lib/assets/bar/center_active2.png'));
                      },
                    ),
                    ItemCard(
                      title: 'Clear cache',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: _arrow(),
                      textColor: RedColor,
                      callback: () {
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.warning,
                            text: "Clear cache",
                            confirmBtnText: "Confirm",
                            confirmBtnColor: Colors.red[600],
                            onConfirmBtnTap: () {},
                            cancelBtnText: "Cancel",
                            showCancelBtn: true,
                            backgroundColor: BaseColor);
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Info',
                        style: GoogleFonts.heebo(
                            fontSize: 22,
                            height: 1.5,
                            fontWeight: FontWeight.w700,
                            color: BaseColor),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ItemCard(
                      title: 'Notifications',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: Icon(
                        Icons.notifications,
                        color: BaseColor,
                      ),
                      callback: () {
                        SystemSetting.goto(SettingTarget.NOTIFICATION);
                      },
                    ),
                    ItemCard(
                      title: 'Rate',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: Icon(
                        Icons.rate_review,
                        color: BaseColor,
                      ),
                      callback: () {
                        Fluttertoast.showToast(
                          msg: "Coming soon",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: BaseColor.withOpacity(.5),
                          textColor: Colors.black,
                          fontSize: 16.0,
                        );
                      },
                    ),
                    ItemCard(
                      title: 'Support',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Colors.black,
                      rightWidget: null,
                      callback: () {
                        Fluttertoast.showToast(
                          msg: "Coming soon",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: BaseColor.withOpacity(.5),
                          textColor: Colors.black,
                          fontSize: 16.0,
                        );
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Other',
                        style: GoogleFonts.heebo(
                            fontSize: 22,
                            height: 1.5,
                            fontWeight: FontWeight.w700,
                            color: BaseColor),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ItemCard(
                      title: 'Visit',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: null,
                      callback: () {
                        print('Tap Settings Item 08');
                      },
                    ),
                    ItemCard(
                      title: 'Report Bugs',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      callback: () {
                        print('Tap Settings Item 09');
                      },
                      textColor: Colors.red,
                    ),
                    ItemCard(
                      title: 'Version',
                      color: (brightness == Brightness.light)
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      rightWidget: Center(
                        child: Text(
                          'Oukami v1.0.0',
                          style: GoogleFonts.heebo(
                            fontSize: 15,
                            height: 1.8,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      callback: () {},
                    ),
                    SizedBox(
                      height: 200,
                    ),
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

class SettingsTile extends StatelessWidget {
  final String text;
  final Widget trailing;

  const SettingsTile(this.text, this.trailing);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      trailing: trailing,
      onTap: () {},
    );
  }
}
