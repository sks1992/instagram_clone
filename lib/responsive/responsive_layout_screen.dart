import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/util/constants.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);

  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  bool isLoading = false;

  @override
  void initState() {
    addData();
    super.initState();
  }

  void addData() async {
    setState(() {
      isLoading = true;
    });
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        //show web Screen
        return isLoading
            ? const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : widget.webScreenLayout;
      }
      //show mobile Screen
      return isLoading
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            )
          : widget.mobileScreenLayout;
    });
  }
}
