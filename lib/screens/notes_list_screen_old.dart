import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:noteapp/components/app_bar_with_menu_option.dart';
import 'package:noteapp/components/app_bar_with_search_and_icon.dart';
import 'package:noteapp/components/no_notes_found.dart';
import 'package:noteapp/components/note_item.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/controllers/notes_list_controller.dart';
import 'package:noteapp/models/home_task_item_model.dart';
import 'package:noteapp/screens/add_task_screen.dart';
import 'package:noteapp/utils/multi_select_item.dart';
import 'package:noteapp/utils/reorderable_items_view.dart';

class NotesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notesListController = Get.find<NotesListController>();
    notesListController
        .initSelectionSize(notesListController.getActiveNotesList().length);
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
            // buildAppBar(context),
            Obx(
              () => notesListController.isSelectingList.value
                  ? AppBarWithMenuOption(
                      isArchiveScreen: false,
                      onArchiveClicked: (List<int> selectedIndexes) {
                        // Getting selected list items from selected indexes And creating a copy. Otherwise
                        // getArchivedList will throw outOfBound exception because everytime you archive a
                        // list item, list size changes
                        List<HomeTaskItemModel> selectedListItems =
                            selectedIndexes
                                .map((index) => notesListController
                                    .getActiveNotesList()[index])
                                .toList();
                        selectedListItems.forEach((element) {
                          notesListController.archiveNote(element, false);
                        });
                        notesListController.resetSelection();
                        notesListController.filteredNotesList.refresh();
                        notesListController.update();
                      },
                      onDeleteClicked: (List<int> selectedIndexes) {
                        Get.defaultDialog(
                            radius: 8,
                            title: 'Confirmation',
                            middleText:
                                'This cannot be undone. Are you sure to delete all notes?',
                            confirm: TextButton(
                              onPressed: () {
                                List<HomeTaskItemModel> selectedListItems =
                                    selectedIndexes
                                        .map((index) => notesListController
                                            .getActiveNotesList()[index])
                                        .toList();
                                selectedListItems.forEach((element) {
                                  notesListController.deleteNoteFromNotesList(
                                      element, false);
                                  notesListController
                                      .deleteNoteFromDatabase(element);
                                });
                                notesListController.resetSelection();
                                notesListController.filteredNotesList.refresh();
                                notesListController.update();
                                Get.back();
                              },
                              child: Text('Delete'),
                            ),
                            cancel: TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('Cancel'),
                            ));
                      },
                    )
                  : AppBarWithSearchAndIcon(
                      showArchiveNotes: false,
                    ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Flexible(
              child: GetX<NotesListController>(initState: (_) {
                print(_);
                print('Notes list getX Init triggered');
              }, builder: (controller) {
                print('Notes list builder called');
                return notesListController.getActiveNotesList().isEmpty
                    ? NoNotesFound()
                    : ReorderableItemsView(
                        feedBackWidgetBuilder: (context, index, child) =>
                            Container(
                              // height: 150,
                              // width: 200,
                              color: Colors.deepPurple,
                              child: child,
                            ),
                        longPressToDrag: true,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        children: getNotesList(),
                        onReorder: (oldIndex, newIndex) {
                          int realOldIndex = notesListController
                              .filteredNotesList
                              .indexOf(notesListController
                                  .getActiveNotesList()[oldIndex]);
                          int realNewIndex = notesListController
                              .getActiveNotesList()
                              .indexOf(notesListController
                                  .getActiveNotesList()[newIndex]);
                          notesListController.reorderNote(
                              realNewIndex, realOldIndex);
                        },
                        isGrid: notesListController.isGrid.value,
                        crossAxisCount: 2,
                        staggeredTiles: List.generate(
                          notesListController.getActiveNotesList().length,
                          (index) =>
                              // StaggeredTile.fit(1)
                              StaggeredTileExtended.count(
                                  1,
                                  notesListController
                                              .getActiveNotesList()[index]
                                              .todoItemList
                                              .length >
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
    final notesListController = Get.find<NotesListController>();
    print(
        'Setting notes list getActiveNotes size = ${notesListController.getActiveNotesList().length}');
    var list = <Widget>[];
    notesListController
        .getActiveNotesList()
        // .notesListController
        // .filteredNotesList
        .asMap()
        .forEach((index, _) {
      HomeTaskItemModel homeTaskItemModel =
          notesListController.getActiveNotesList()[index];
      // if (!notesListController.filteredNotesList[index].isArchived) {
      list.add(GetBuilder<NotesListController>(
        initState: (state) => print('Nested note Item init state called'),
        key: Key(homeTaskItemModel.key.toString()),
        builder: (logic) {
          print(
              'Nested note Item get builder called ${homeTaskItemModel.title}');
          return notesListController.multiSelectController.isSelecting
              ? MultiSelectItem(
                  isSelecting:
                      notesListController.multiSelectController.isSelecting,
                  onSelected: () {
                    print('${homeTaskItemModel.title} selected');
                    notesListController.toggleSelectedIndex(index);
                  },
                  child: AbsorbPointer(
                    absorbing: true,
                    child: Container(
                      decoration: notesListController.multiSelectController
                              .isSelected(index)
                          ? new BoxDecoration(
                              color: Get.theme.primaryColor,
                              borderRadius: BorderRadius.circular(10))
                          : new BoxDecoration(),
                      child: NoteItem(
                        homeTaskItemModel: homeTaskItemModel,
                        onNoteItemClicked:
                            (HomeTaskItemModel homeTaskItemModel) {},
                      ),
                    ),
                  ),
                )
              : Dismissible(
                  key: Key(homeTaskItemModel.key.toString()),
                  onDismissed: (direction) {
                    notesListController.archiveNote(homeTaskItemModel);
                  },
                  child: NoteItem(
                    homeTaskItemModel: homeTaskItemModel,
                    onNoteItemClicked: (HomeTaskItemModel homeTaskItemModel) {
                      Get.to(
                        () => AddTaskScreen(
                          homeTaskItemModel: homeTaskItemModel,
                        ),
                        transition: Transition.zoom,
                      );
                    },
                  ),
                );
        },
      )
          // GetBuilder<NotesListController>(
          //   init: NotesListController(),
          //   key: Key(
          //       notesListController.getActiveNotesList()[index].key.toString()),
          //   builder: (notesListController) {
          //     // if (!notesListController.filteredNotesList[index].isArchived)
          //     return Dismissible(
          //       key: Key(notesListController
          //           .getActiveNotesList()[index]
          //           .key
          //           .toString()),
          //       onDismissed: (direction) {
          //         notesListController.archiveNote(
          //             notesListController.getActiveNotesList()[index]);
          //       },
          //       child: NoteItem(
          //         homeTaskItemModel:
          //             notesListController.getActiveNotesList()[index],
          //       ),
          //     );
          //     // else
          //     //   return Visibility(
          //     //     visible: false,
          //     //     child: Container(
          //     //       height: 5,
          //     //       width: 5,
          //     //       color: Colors.red,
          //     //     ),
          //     //   );
          //   },
          // ),
          );
      // }
    });
    return list;
  }
}
