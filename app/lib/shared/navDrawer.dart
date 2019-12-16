import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jinya_app/accountManagement/newAccount.dart';
import 'package:jinya_app/data/accountDatabase.dart';
import 'package:jinya_app/localizations.dart';

class JinyaNavigationDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
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
  bool _showDrawerContents = true;
  Account currentUser;
  List<Account> accounts = List<Account>();

  void loadAccounts() async {
    var values = await getAccounts();
    var accs = List<Account>();
    Account currUser;
    if (values.length > 0) {
      if (currentUser == null && values.length > 0) {
        currUser = values.first;
      } else {
        currUser = currentUser;
      }

      var otherAccounts =
          values.where((account) => account.url != currUser.url);
      if (otherAccounts.isNotEmpty) {
        accs.addAll(otherAccounts);
      }
      setState(() {
        accounts = accs;
        currentUser = currUser;
      });
    } else {
      _animationController.forward();
    }
  }

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
    loadAccounts();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = JinyaLocalizations.of(context);
    final List<String> _drawerContents = <String>[
      l10n.menuMedia,
      l10n.menuPages,
      l10n.menuForms,
      l10n.menuArtists,
      l10n.menuThemes,
      l10n.menuMenus,
    ];

    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(currentUser?.name ?? ''),
            accountEmail: Text(
              currentUser != null ? Uri.parse(currentUser.url).host : '',
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  '${currentUser?.url}/api/user/${currentUser?.jinyaId}/profilepicture',
                  headers: {'JinyaApiKey': currentUser?.apiKey}),
            ),
            otherAccountsPictures: accounts
                .map(
                  (account) =>
                  GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      setState(() {
                        currentUser = account;
                      });
                    },
                    child: Semantics(
                      label: l10n.menuSwitchAccount(account.name),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${account.url}/api/user/${account
                                .jinyaId}/profilepicture'),
                      ),
                    ),
                  ),
            )
                .toList(),
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
                          children: _drawerContents.map<Widget>((String id) {
                            return ListTile(
                              title: Text(id),
                            );
                          }).toList(),
                        ),
                      ),
                      SlideTransition(
                        position: _drawerDetailsPosition,
                        child: FadeTransition(
                          opacity: ReverseAnimation(_drawerContentsOpacity),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              ListTile(
                                leading: const Icon(Icons.add),
                                title: Text(l10n.menuAddAccount),
                                onTap: () =>
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NewAccountPage(),
                                      ),
                                    ),
                              ),
                              ListTile(
                                leading: const Icon(Icons.settings),
                                title: Text(l10n.menuManageAccounts),
                              ),
                            ],
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
