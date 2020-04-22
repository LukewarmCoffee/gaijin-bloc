import 'package:flutter/material.dart';

import 'routes.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('Profile'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Words'),
            onTap: () {
              Navigator.popAndPushNamed(context, Routes.wordsPage);
            },
          ),
          ListTile(
            title: Text('Create'),
            onTap: () {
              //Navigator.popAndPushNamed(context, Build.routeName);
            },
          ),
          ListTile(
            title: Text('Review'),
            onTap: () {
              //Navigator.popAndPushNamed(context, Review.routeName);
            },
          ),
        ],
      ),
    );
  }
}
