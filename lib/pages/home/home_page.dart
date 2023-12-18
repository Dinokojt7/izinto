import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../cart/post_checkout/cart_history_items.dart';
import '../notifications/inbox_view.dart';
import '../options/profile_settings.dart';
import '../options/settings_view/main_settings_view.dart';
import 'main_components/main_specialty_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  int _selectedIndex = 0;
  late PersistentTabController _controller;
  CollectionReference _referenceUserInfo =
      FirebaseFirestore.instance.collection('izinto');
  late Stream<QuerySnapshot> _streamUserInfo;
  String _name = 'Guest user';
  String _address = '';
  String _surname = '';
  DateTime? storedTime;
  DateTime? carTime;

  List pages = [
    const MainSpecialtyPage(),
    // const HubView(),
    const CartHistoryItems(),
    const InboxView(),
    const MainSettingsView(),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getTime();
    _streamUserInfo = _referenceUserInfo.snapshots();
    _prefferedAddress();
    _getData();
    getCarWashTime();
    _controller = PersistentTabController(initialIndex: 0);
  }

  //Get time for next laundry
  void getCarWashTime() async {
    User? user = await _firebaseAuth.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('Subscriptions')
        .doc('car subscription')
        .snapshots()
        .listen((userData) {
      if (mounted)
        setState(() {
          carTime = userData['date'].toDate();
          ;
        });
    });
  }

  //Get time for next car wash
  void getTime() async {
    User? user = await _firebaseAuth.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('Subscriptions')
        .doc('plan')
        .snapshots()
        .listen((userData) {
      if (mounted)
        setState(() {
          storedTime = userData['date'].toDate();

          ;
        });
    });
  }

  void _getData() async {
    User? user = await _firebaseAuth.currentUser;

    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .snapshots()
        .listen((userData) {
      setState(() {
        _name = userData['name'];
        _surname = userData['surname'];
      });
    });
  }

  void _prefferedAddress() async {
    User? user = await _firebaseAuth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection("Addresses")
        .doc('preffered address')
        .snapshots()
        .listen((userData) {
      setState(() {
        _address = userData['address'];
      });
    });
  }

  List<Widget> buildScreens() {
    return [
      MainSpecialtyPage(),
      // HubView(),
      CartHistoryItems(),
      InboxView(),
      Container(
        child: Text('Next next next nextpage'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if (user != null) {
      return StreamBuilder<QuerySnapshot>(
        stream: _streamUserInfo,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            print(
              snapshot.error.toString(),
            );
            Center(
              child: Text(
                (snapshot.error.toString()),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.active) {
            QuerySnapshot querySnapshot = snapshot.data;

            if (_name != '' && _surname != '') {
              return Scaffold(
                body: pages[_selectedIndex],
                bottomNavigationBar: BottomAppBar(
                  shape: CircularNotchedRectangle(),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 0.5,
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius15),
                        topRight: Radius.circular(Dimensions.radius15),
                      ),
                    ),
                    child: BottomNavigationBar(
                        unselectedFontSize: 11,
                        selectedFontSize: 11,
                        backgroundColor: Colors.white,
                        selectedItemColor: Color(0xff966C3B),
                        unselectedItemColor: Color(0xff9A9483),
                        //D0C9C0
                        elevation: 0,
                        type: BottomNavigationBarType.fixed,
                        showSelectedLabels: true,
                        showUnselectedLabels: true,
                        selectedLabelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                        unselectedLabelStyle: TextStyle(
                          color: AppColors.mainColor,
                        ),
                        // selectedFontSize: 0.0,

                        currentIndex: _selectedIndex,
                        onTap: onTapNav,
                        items: [
                          BottomNavigationBarItem(
                            icon: Icon(
                              Icons.home_max_outlined,
                            ),
                            label: 'Home',
                          ),
                          // BottomNavigationBarItem(
                          //   icon: Icon(Icons.dry_cleaning),
                          //   label: 'Services',
                          // ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.dry_cleaning),
                            label: 'Orders',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(
                              Icons.messenger_outline_rounded,
                            ),
                            label: 'Inbox',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(
                              Icons.person,
                            ),
                            label: user == null ? 'Log In' : 'Profile',
                          )
                        ]),
                  ),
                ),
              );
            } else {
              return ProfileSettings(
                isPhoneAuth: false,
              );
            }
          }

          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: const Color(0xffB09B71),
              ),
            ),
          );
        },
      );
    } else {
      return Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          clipBehavior: Clip.antiAlias,
          child: Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 0.5,
                ),
              ],
            ),
            child: BottomNavigationBar(
                unselectedFontSize: 11,
                selectedFontSize: 11,
                backgroundColor: Colors.white,
                selectedItemColor: Color(0xff966C3B),
                unselectedItemColor: Color(0xff9A9483),
                //D0C9C0
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(
                  color: AppColors.mainColor,
                ),
                // selectedFontSize: 0.0,

                currentIndex: _selectedIndex,
                onTap: onTapNav,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_max_outlined,
                    ),
                    label: 'Home',
                  ),
                  // BottomNavigationBarItem(
                  //   icon: Icon(Icons.dry_cleaning),
                  //   label: 'Services',
                  // ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dry_cleaning),
                    label: 'Orders',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.messenger_outline_rounded,
                    ),
                    label: 'Inbox',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                    ),
                    label: user == null ? 'Log In' : 'Profile',
                  )
                ]),
          ),
        ),
      );
    }
  }
}
