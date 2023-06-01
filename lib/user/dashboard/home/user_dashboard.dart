import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/user/dashboard/home/user_home.dart';
import 'package:ceuk_user_app/user/dashboard/profile/my_account.dart';
import 'package:ceuk_user_app/user/dashboard/request/request_history_page.dart';
import 'package:ceuk_user_app/user/dashboard/transaction/user_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class UserDashboardPage extends StatefulWidget {
  const UserDashboardPage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<UserDashboardPage> {
  int _pageIndex = 0;

  static final List<Widget> _tabPages = <Widget>[
    const UserHomePage(),
    const UserRequestHistory(),
    const USersTransactionsPage(),
    const MyAccountPage()
  ];

  void _onTabbed(int index) {
    setState(() {
      _pageIndex = index;
      _pageController.jumpToPage(_pageIndex);
    });
  }

  final GlobalKey<ScaffoldState> _homeKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _homeKey,
        extendBodyBehindAppBar: true,
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _tabPages,
        ),
        bottomNavigationBar: BottomNavigationBar(
            // backgroundColor: const Color(0xFF101828),
            backgroundColor: UIColors.white,
            elevation: 10,
            // fixedColor: Colors.white,
            enableFeedback: true,
            selectedLabelStyle: TextStyle(
                fontSize: 12.sp, height: 1.6, color: UIColors.primary200),
            unselectedLabelStyle: TextStyle(
                fontSize: 12.sp, height: 1.6, color: UIColors.secondary300),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: UIColors.primary100,
            unselectedItemColor: UIColors.secondary300,
            currentIndex: _pageIndex,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedFontSize: 9,
            unselectedFontSize: 9,
            iconSize: 22,
            onTap: _onTabbed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 0.004.sh, top: 0.003.sh),
                    child: const Icon(Iconsax.home),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 0.004.sh, top: 0.003.sh),
                    child: const Icon(Iconsax.home),
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 0.00.sh, top: 0.00.sh),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0.004.sh, top: 0.003.sh),
                      child: const Icon(Iconsax.people),
                    ),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 0.00.sh, top: 0.00.sh),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0.004.sh, top: 0.003.sh),
                      child: const Icon(Iconsax.people),
                    ),
                  ),
                  label: 'Request History'),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 0.004.sh, top: 0.003.sh),
                    child: const Icon(
                      Iconsax.money,
                    ),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 0.004.sh, top: 0.003.sh),
                    child: const Icon(
                      Iconsax.money,
                    ),
                  ),
                  label: 'Transactions'),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 0.00.sh, top: 0.00.sh),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0.004.sh, top: 0.003.sh),
                      child: const Icon(Iconsax.user),
                    ),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 0.00.sh, top: 0.00.sh),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0.004.sh, top: 0.003.sh),
                      child: const Icon(Iconsax.user),
                    ),
                  ),
                  label: 'Account')
            ]),
      ),
    );
  }
}
