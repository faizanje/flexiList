import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:noteapp/controllers/notes_list_controller.dart';
import 'package:noteapp/controllers/sidebar_controller.dart';

class AppBarWithSearchAndIcon extends StatelessWidget {
  const AppBarWithSearchAndIcon({
    Key? key,
    required this.showArchiveNotes,
  }) : super(key: key);

  final bool showArchiveNotes;

  @override
  Widget build(BuildContext context) {
    final notesListController = Get.find<NotesListController>();
    return Row(
      children: <Widget>[
        // IconButton(
        //   onPressed: () {},
        //   icon: SvgPicture.asset(
        //     'assets/images/menu_icon.svg',
        //     color: Theme.of(context).primaryColor,
        //   ),
        // ),
        Container(
          margin: EdgeInsets.only(top: 5, left: 10),
          alignment: AlignmentDirectional.centerStart,
          width: 290.w,
          height: 42.h,
          decoration: BoxDecoration(
            color: Get.theme.primaryColorDark,
            border: Border.all(
                color: Get.theme.primaryColor.withOpacity(0.5), width: 1.5),

            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            // color: ,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: TextField(
              controller: notesListController.searchController,
              decoration: InputDecoration(
                suffixIcon: Obx(
                  () => GestureDetector(
                    onTap: () {
                      if (notesListController.isSearching.value) {
                        notesListController.searchController.clear();
                        notesListController.onSearched('', showArchiveNotes);
                      }
                    },
                    child: Icon(
                      notesListController.isSearching.value
                          ? Icons.cancel_outlined
                          : Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                border: InputBorder.none,
                hintText: 'kHintText'.tr,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: (newValue) {
                notesListController.onSearched(newValue, showArchiveNotes);
              },
            ),
          ),
        ),
        Obx(() {
          return IconButton(
            padding: EdgeInsets.all(2.5),
            constraints: BoxConstraints(
                // minWidth: kMinInteractiveDimension - 10,
                ),
            onPressed: () {
              notesListController.toggleIsGrid();
            },
            icon: notesListController.isGrid.value
                ? SvgPicture.asset(
                    'assets/icons/list.svg',
                    color: Theme.of(context).primaryColor,
                  )
                : SvgPicture.asset(
                    'assets/icons/grid_view_black_24dp.svg',
                    color: Theme.of(context).primaryColor,
                  ),
          );
        }),
        IconButton(
          padding: EdgeInsets.all(2.5),
          constraints: BoxConstraints(
              // minWidth: kMinInteractiveDimension - 20,
              ),
          onPressed: () {
            notesListController.setIsSelectingList(true);
          },
          icon: Image.asset(
            'assets/icons/check.png',
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
