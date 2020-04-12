import 'package:flutter/material.dart';
import 'package:jinya_app/content/media/fileManagement/overview.dart';
import 'package:jinya_app/content/media/galleryManagement/overview.dart';
import 'package:jinya_app/localizations.dart';
import 'package:jinya_app/network/media/files.dart';
import 'package:jinya_app/shared/navDrawer.dart';

enum MediaTab {
  Files,
  Galleries,
}

class MediaOverviewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MediaOverviewPageState(tab);
  }

  final MediaTab tab;

  MediaOverviewPage(this.tab);
}

class MediaOverviewPageState extends State<MediaOverviewPage> {
  var files = List<File>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final MediaTab tab;
  final fileTab = FilesOverviewWidget();
  final galleryTab = GalleriesOverviewWidget();

  MediaOverviewPageState(this.tab);

  void loadFiles() async {
    final fileList = await getFiles();
    setState(() {
      files = fileList;
    });
  }

  @override
  void initState() {
    super.initState();
    getFiles();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = JinyaLocalizations.of(context);

    final tabController = DefaultTabController(
      length: 2,
      initialIndex: tab == MediaTab.Files ? 0 : 1,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(l10n.manageMediaTitle),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                switch (tab) {
                  case MediaTab.Files:
                    await fileTab.executeNew();
                    break;
                  case MediaTab.Galleries:
                    await galleryTab.executeNew();
                    break;
                }
              },
            )
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                text: l10n.manageMediaFiles.toUpperCase(),
              ),
              Tab(
                text: l10n.manageMediaGalleries.toUpperCase(),
              ),
            ],
          ),
        ),
        drawer: JinyaNavigationDrawer(),
        body: TabBarView(
          children: [
            fileTab,
            galleryTab,
          ],
        ),
      ),
    );

    return tabController;
  }
}
