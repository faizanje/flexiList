import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:noteapp/components/no_notes_found.dart';
import 'package:noteapp/components/note_item.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/controllers/notes_list_controller.dart';
import 'package:noteapp/screens/layout_screen.dart';
import 'package:reorderableitemsview/reorderableitemsview.dart';

class ArchiveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notesListController = Get.find<NotesListController>();
    // Get.changeTheme(ThemeData.dark());
    // Get.find();
    List<Widget> notesList = <Widget>[];
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(bottom: 40),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 4.h,
            ),
            buildAppBar(context),
            SizedBox(
              height: 12.h,
            ),
            Flexible(
              child: GetX<NotesListController>(initState: (_) {
                print(_);
                print('Notes list triggereda');
              }, builder: (controller) {
                print('Notes list builder called');
                return notesListController.archivedNotesList.isEmpty
                    ? NoNotesFound()
                    : ReorderableItemsView(
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        children: getNotesList(),
                        onReorder: (oldIndex, newIndex) {
                          int realOldIndex = notesListController
                              .filteredNotesList
                              .indexOf(notesListController
                                  .archivedNotesList[oldIndex]);
                          int realNewIndex = notesListController
                              .filteredNotesList
                              .indexOf(notesListController
                                  .archivedNotesList[newIndex]);
                          notesListController.reorderNote(
                              realNewIndex, realOldIndex);
                        },
                        isGrid: notesListController.isGrid.value,
                        crossAxisCount: 2,
                        staggeredTiles: List.generate(
                          notesListController.archivedNotesList.length,
                          (index) => StaggeredTileExtended.count(
                              1,
                              notesListController.archivedNotesList[index]
                                          .todoItemList.length >
                                      2
                                  ? 1.15.h
                                  : 1.h),
                        ));
              }),
            ),

            // Card(
            //   child: Flexible(
            //     child: ConstrainedBox(
            //       constraints:
            //       BoxConstraints(maxHeight: 216.h, minWidth: 142.w),
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Column(
            //           mainAxisSize: MainAxisSize.min,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               'Title',
            //               style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 16.sp,
            //               ),
            //             ),
            //             Container(
            //               width: MediaQuery.of(context).size.width * 0.5,
            //               child: CheckboxListTile(
            //                 activeColor: kPrimaryColor,
            //                 dense: true,
            //                 contentPadding: EdgeInsets.all(0),
            //                 controlAffinity: ListTileControlAffinity.leading,
            //                 tristate: true,
            //                 title: Text(
            //                   'List Item',
            //                   style: TextStyle(fontSize: 16),
            //                 ),
            //                 value: false,
            //                 onChanged: (bool? value) {},
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // )
            // _NoNotesFound(),
          ],
        ),
      ),
    );
  }

  getNotesList() {
    print('Setting notes list');
    // archivedNotesList.clear();
    final notesListController = Get.find<NotesListController>();

    // return notesListController.archivedNotesList.map((e) => null)
    // int index = 0;

    var list = <Widget>[];
    // for (var index = 0; index < notesListController.archivedNotesList.length; index++) {
    //   list.add(Container(
    //     key: ValueKey(notesListController.archivedNotesList[index].key),
    //     child: Obx(
    //       () => Dismissible(
    //         key: Key(notesListController.archivedNotesList[index].key.toString()),
    //         onDismissed: (direction) {
    //           notesListController
    //               .archiveNote(notesListController.archivedNotesList[index]);
    //         },
    //         child: NoteItem(
    //           homeTaskItemModel: notesListController.archivedNotesList[index],
    //         ),
    //       ),
    //     ),
    //   ));
    // }

    // return list;
    // return notesListController.archivedNotesList.map((e) {
    //   index++;
    //   return
    //   index++;
    // }).toList(growable: true);
    notesListController.filteredNotesList.asMap().forEach((index, _) {
      if (notesListController.filteredNotesList[index].isArchived) {
        list.add(
          GetBuilder<NotesListController>(
            init: NotesListController(),
            key: Key(
                notesListController.filteredNotesList[index].key.toString()),
            builder: (notesListController) {
              if (notesListController.filteredNotesList[index].isArchived)
                return Dismissible(
                  key: Key(notesListController.filteredNotesList[index].key
                      .toString()),
                  onDismissed: (direction) {
                    notesListController.deleteNote(
                        notesListController.filteredNotesList[index]);
                  },
                  child: NoteItem(
                    homeTaskItemModel:
                        notesListController.filteredNotesList[index],
                  ),
                );
              else
                return Visibility(
                  visible: false,
                  child: Container(
                    height: 5,
                    width: 5,
                    color: Colors.red,
                  ),
                );
            },
          ),
        );
      }
    });
    return list;
  }

  Row buildAppBar(BuildContext context) {
    final notesListController = Get.find<NotesListController>();
    return Row(
      children: <Widget>[
        Obx(() {
          return IconButton(
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
        Container(
          alignment: AlignmentDirectional.centerStart,
          width: 297.w,
          height: 42.h,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(3, 5),
              ),
            ],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            color: Colors.white,
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
                        notesListController.onSearched('', true);
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
                notesListController.onSearched(newValue, false);
              },
            ),
          ),
        ),
      ],
    );
  }
}
