import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class JinyaNavigationDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return JinyaNavigationDrawerState();
  }
}

class JinyaNavigationDrawerState extends State<JinyaNavigationDrawer>
    with TickerProviderStateMixin {
  static final Animatable<Offset> _drawerDetailsTween = Tween<Offset>(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  ).chain(CurveTween(
    curve: Curves.fastOutSlowIn,
  ));

  AnimationController _animationController;
  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;
  var _showDrawerContents = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _drawerContentsOpacity = CurvedAnimation(
      parent: ReverseAnimation(_animationController),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = _animationController.drive(_drawerDetailsTween);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _drawerContents = <String>[
    ];

    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(''),
            accountEmail: Text(''),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(''),
            ),
            otherAccountsPictures: [].toList(),
            onDetailsPressed: () {
              _showDrawerContents = !_showDrawerContents;
              if (_showDrawerContents)
                _animationController.reverse();
              else
                _animationController.forward();
            },
          ),
          MediaQuery.removePadding(
            context: context,
            // DrawerHeader consumes top MediaQuery padding.
            removeTop: true,
            child: Expanded(
              child: ListView(
                dragStartBehavior: DragStartBehavior.down,
                padding: const EdgeInsets.only(top: 8.0),
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      // The initial contents of the drawer.
                      FadeTransition(
                        opacity: _drawerContentsOpacity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                        ),
                      ),
                      SlideTransition(
                        position: _drawerDetailsPosition,
                        child: FadeTransition(
                          opacity: ReverseAnimation(_drawerContentsOpacity),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
