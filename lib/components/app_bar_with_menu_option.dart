import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:noteapp/controllers/notes_list_controller.dart';
import 'package:noteapp/controllers/sidebar_controller.dart';

class AppBarWithMenuOption extends StatelessWidget {
  final bool isArchiveScreen;
  final Function(List<int> selectedIndexes) onArchiveClicked;
  final Function(List<int> selectedIndexes) onDeleteClicked;
  final Function(List<int> selectedIndexes)? onShareClicked;
  const AppBarWithMenuOption({
    Key? key,
    required this.isArchiveScreen,
    required this.onArchiveClicked,
    required this.onDeleteClicked,
    this.onShareClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notesListController = Get.find<NotesListController>();
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          notesListController.resetSelection();
        },
        icon: Icon(
          Icons.close,
          color: context.theme.primaryColor,
        ),
      ),
      title: Obx(() => Text(
            '${notesListController.selectedItemsCount}',
            style: TextStyle(color: Get.theme.primaryColor, fontSize: 18),
          )),
      actions: [
        Tooltip(
          message: 'Share notes',
          child: IconButton(
            onPressed: () {
              if (onShareClicked != null)
                onShareClicked!(
                    notesListController.multiSelectController.selectedIndexes);
            },
            icon: Icon(
              Icons.send,
              color: context.theme.primaryColor,
            ),
          ),
        ),
        Tooltip(
          message: this.isArchiveScreen ? 'Unarchive' : 'Archive',
          child: IconButton(
            onPressed: () {
              onArchiveClicked(
                  notesListController.multiSelectController.selectedIndexes);
            },
            icon: Icon(
              this.isArchiveScreen ? Icons.unarchive : Icons.archive,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
          ),
        ),
        Tooltip(
          message: 'Delete',
          child: IconButton(
            onPressed: () {
              onDeleteClicked(
                notesListController.multiSelectController.selectedIndexes,
              );
            },
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
          ),
        )
      ],
      // children: <Widget>[
      //   IconButton(
      //     onPressed: () {
      //       notesListController.isSelectingList.value = false;
      //     },
      //     icon: Icon(
      //       Icons.close,
      //       color: context.theme.primaryColor,
      //     ),
      //   ),
      //   Container(
      //     margin: EdgeInsets.only(top: 5),
      //     alignment: AlignmentDirectional.centerStart,
      //     width: 260.w,
      //     height: 42.h,
      //   ),
      //   IconButton(
      //     onPressed: () {},
      //     icon: Icon(
      //       this.isArchiveScreen ? Icons.unarchive : Icons.archive,
      //       color: Theme.of(context).primaryColor,
      //       size: 30,
      //     ),
      //   ),
      //   Obx(() {
      //     return IconButton(
      //       padding: EdgeInsets.all(2.5),
      //       constraints: BoxConstraints(
      //           // minWidth: kMinInteractiveDimension - 10,
      //           ),
      //       onPressed: () {
      //         notesListController.toggleIsGrid();
      //       },
      //       icon: notesListController.isGrid.value
      //           ? SvgPicture.asset(
      //               'assets/icons/list.svg',
      //               color: Theme.of(context).primaryColor,
      //             )
      //           : SvgPicture.asset(
      //               'assets/icons/grid_view_black_24dp.svg',
      //               color: Theme.of(context).primaryColor,
      //             ),
      //     );
      //   }),
      //   IconButton(
      //     padding: EdgeInsets.all(2.5),
      //     constraints: BoxConstraints(
      //         // minWidth: kMinInteractiveDimension - 20,
      //         ),
      //     onPressed: () {
      //       notesListController.toggleIsGrid();
      //     },
      //     icon: Image.asset(
      //       'assets/icons/check.png',
      //       color: Theme.of(context).primaryColor,
      //     ),
      //   ),
      // ],
    );
  }
}
