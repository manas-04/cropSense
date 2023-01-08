import 'package:crop_sense/presentation/helpers/color_helper.dart';
import 'package:crop_sense/presentation/helpers/size_helper.dart';
import 'package:crop_sense/presentation/side_drawer/custom_icon_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/side_drawer/side_drawer_bloc.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SideDrawerBloc(InitialSideDrawerState()),
      child: BlocConsumer<SideDrawerBloc, SideDrawerState>(
        listener: (context, state) {
          if (state is ResourceTileClickedState) {}
          if (state is GalleryTileClickedState) {}
          if (state is AboutUsTileClickedState) {}
          if (state is ProjectTeamTileClickedState) {}
          if (state is ContactUsTileClickedState) {}
        },
        builder: (context, state) {
          return SafeArea(
            child: Container(
              height: double.infinity,
              width: displayWidth(context) * 0.7,
              color: Colors.white,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: displayHeight(context) * 0.04,
                    ),
                    Image.asset(
                      "assets/images/logo.png",
                      height: displayHeight(context) * 0.1,
                      fit: BoxFit.fitHeight,
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.03,
                    ),
                    CustomIconListTile(
                      icon: "assets/images/teamwork.png",
                      text: "Resources",
                      color: primaryColor2,
                      press: () {
                        context
                            .read<SideDrawerBloc>()
                            .add(ResourceTileClickedEvent());
                      },
                    ),
                    CustomIconListTile(
                      icon: "assets/images/gallery.png",
                      text: "Gallery",
                      color: primaryColor2,
                      press: () {
                        context
                            .read<SideDrawerBloc>()
                            .add(GalleryTileClickedEvent());
                      },
                    ),
                    CustomIconListTile(
                      icon: "assets/images/about-us.png",
                      text: "About Us",
                      color: primaryColor2,
                      press: () {
                        context
                            .read<SideDrawerBloc>()
                            .add(AboutUsTileClickedEvent());
                      },
                    ),
                    CustomIconListTile(
                      icon: "assets/images/team.png",
                      text: "Project Team",
                      color: primaryColor2,
                      press: () {
                        context
                            .read<SideDrawerBloc>()
                            .add(ProjectTeamTileClickedEvent());
                      },
                    ),
                    CustomIconListTile(
                      icon: "assets/images/telephone.png",
                      text: "Contact Us",
                      color: primaryColor2,
                      press: () {
                        context
                            .read<SideDrawerBloc>()
                            .add(ContactUsTileClickedEvent());
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
