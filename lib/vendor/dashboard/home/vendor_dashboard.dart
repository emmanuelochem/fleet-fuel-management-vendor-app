import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/vendor/dashboard/home/vendor_home.dart';
import 'package:ceuk_user_app/vendor/dashboard/profile/my_account.dart';
import 'package:ceuk_user_app/vendor/dashboard/staff/vendor_staffs_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ceuk_user_app/vendor/dashboard/transaction/transaction_page.dart';

class VendorDashboard extends StatefulWidget {
  const VendorDashboard({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<VendorDashboard> {
  int _pageIndex = 0;

  static final List<Widget> _tabPages = <Widget>[
    const VendorHomePage(),
    const VendorsTransactionPage(),
    const VendorsStaffsPage(),
    const VendorAccountPage(),
    //Container()
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
                  label: 'Staffs'),
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
                  label: 'My Account')
            ]),
      ),
    );
  }
}
