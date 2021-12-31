import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:noteapp/components/app_bar_with_menu_option.dart';
import 'package:noteapp/components/app_bar_with_search_and_icon.dart';
import 'package:noteapp/components/circular_color_container.dart';
import 'package:noteapp/components/no_notes_found.dart';
import 'package:noteapp/components/note_item.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/constant/strings.dart';
import 'package:noteapp/controllers/notes_list_controller.dart';
import 'package:noteapp/models/home_task_item_model.dart';
import 'package:noteapp/screens/add_task_screen.dart';
import 'package:noteapp/screens/layout_screen.dart';
import 'package:noteapp/utils/multi_select_item.dart';
import 'package:noteapp/utils/snack_bar_utils.dart';
import 'package:reorderableitemsview/reorderableitemsview.dart';
import 'package:share_plus/share_plus.dart';

class ArchiveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notesListController = Get.find<NotesListController>();
    notesListController
        .initSelectionSize(notesListController.getArchiveNotesList().length);
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
                      isArchiveScreen: true,
                      onColorPickerClicked: (List<int> selectedIndexes) {
                        List<HomeTaskItemModel> selectedListItems =
                            selectedIndexes
                                .map((index) => notesListController
                                    .getActiveNotesList()[index])
                                .toList();

                        // selectedListItems.forEach((element) {
                        //   element.colorValue[0] = kColorsList[2][0].value;
                        //   element.colorValue[1] = kColorsList[2][1].value;
                        // });

                        Get.defaultDialog(
                          radius: 8,
                          title: 'Select color',
                          barrierDismissible: true,
                          content: Wrap(
                            children: [
                              ...kColorsList
                                  .map(
                                    (e) => Container(
                                      // decoration:
                                      //     BoxDecoration(border: BorderSide()),
                                      margin: EdgeInsets.all(2),
                                      child: CircularColorContainer(
                                        containerColor: e,
                                        onColorChanged: (List<Color> colors) {
                                          selectedListItems.forEach((element) {
                                            element.colorValue[0] =
                                                colors[0].value;
                                            element.colorValue[1] =
                                                colors[1].value;
                                            element.save();
                                          });
                                          notesListController.update();
                                        },
                                      ),
                                    ),
                                  )
                                  .toList()
                            ],
                          ),
                        );
                      },
                      onShareClicked: (List<int> selectedIndexes) {
                        shareNotes(selectedIndexes, notesListController);
                      },
                      onArchiveClicked: (List<int> selectedIndexes) {
                        // Getting selected list items from selected indexes And creating a copy. Otherwise
                        // getArchivedList will throw outOfBound exception because everytime you archive a
                        // list item, list size changes
                        List<HomeTaskItemModel> selectedListItems =
                            selectedIndexes
                                .map((index) => notesListController
                                    .getArchiveNotesList()[index])
                                .toList();
                        selectedListItems.forEach((element) {
                          notesListController.unArchiveNote(element, false);
                        });
                        // selectedIndexes.forEach((index) {
                        //   // print('$index selected');
                        //   print(
                        //       '${notesListController.getArchiveNotesList()[index].title} selected');
                        //   notesListController.unArchiveNote(
                        //       notesListController.getArchiveNotesList()[index],
                        //       false);
                        //   // notesListController
                        //   //     .getArchiveNotesList()[index]
                        //   //     .isArchived = false;
                        // });
                        notesListController.resetSelection();
                        notesListController.filteredNotesList.refresh();
                        notesListController.update();
                      },
                      onDeleteClicked: (List<int> selectedIndexes) {
                        Get.defaultDialog(
                            title: 'Confirmation',
                            middleText:
                                'This cannot be undone. Are you sure to delete all notes?',
                            confirm: TextButton(
                              onPressed: () {
                                List<HomeTaskItemModel> selectedListItems =
                                    selectedIndexes
                                        .map((index) => notesListController
                                            .getArchiveNotesList()[index])
                                        .toList();
                                selectedListItems.forEach((element) {
                                  notesListController.deleteNoteFromNotesList(
                                      element, false);
                                  notesListController
                                      .deleteNoteFromDatabase(element);
                                  Get.back();
                                });
                                notesListController.resetSelection();
                                notesListController.filteredNotesList.refresh();
                                notesListController.update();
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
                      showArchiveNotes: true,
                    ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Flexible(
              child: GetX<NotesListController>(initState: (_) {
                print(_);
                print('Notes list triggereda');
              }, builder: (controller) {
                print('Notes list builder called');
                return notesListController.getArchiveNotesList().isEmpty
                    ? NoNotesFound()
                    : ReorderableItemsView(
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        children: getNotesList(),
                        onReorder: (oldIndex, newIndex) {
                          int realOldIndex = notesListController
                              .filteredNotesList
                              .indexOf(notesListController
                                  .getArchiveNotesList()[oldIndex]);
                          int realNewIndex = notesListController
                              .getArchiveNotesList()
                              .indexOf(notesListController
                                  .getArchiveNotesList()[newIndex]);
                          notesListController.reorderNote(
                              realNewIndex, realOldIndex);
                        },
                        isGrid: notesListController.isGrid.value,
                        crossAxisCount: 2,
                        staggeredTiles: List.generate(
                          notesListController.getArchiveNotesList().length,
                          (index) =>
                              // StaggeredTile.fit(1)
                              StaggeredTileExtended.count(
                                  1,
                                  notesListController
                                              .getArchiveNotesList()[index]
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

  void shareNotes(
      List<int> selectedIndexes, NotesListController notesListController) {
    List<HomeTaskItemModel> selectedListItems = selectedIndexes
        .map((index) => notesListController.getArchiveNotesList()[index])
        .toList();

    String sharedText = '';
    sharedText += 'Total notes: ${selectedIndexes.length}\n';

    selectedListItems.asMap().forEach((index, value) {
      sharedText += '\nNote: ${index + 1}\n';
      sharedText += '\tTitle: ${value.title}\n';
      sharedText += '\tItems: ${value.todoItemList.length}\n';
      value.todoItemList.asMap().forEach((taskItemIndex, taskItem) {
        sharedText += '\t${taskItem.taskName}: ${taskItem.taskStatusStr}\n';
      });
    });
    Share.share(sharedText, subject: kAppName);
  }

  getNotesList() {
    print('Setting notes list');
    // activeNotes.clear();
    final notesListController = Get.find<NotesListController>();

    // return notesListController.activeNotes.map((e) => null)
    // int index = 0;

    var list = <Widget>[];
    // for (var index = 0; index < notesListController.activeNotes.length; index++) {
    //   list.add(Container(
    //     key: ValueKey(notesListController.activeNotes[index].key),
    //     child: Obx(
    //       () => Dismissible(
    //         key: Key(notesListController.activeNotes[index].key.toString()),
    //         onDismissed: (direction) {
    //           notesListController
    //               .archiveNote(notesListController.activeNotes[index]);
    //         },
    //         child: NoteItem(
    //           homeTaskItemModel: notesListController.activeNotes[index],
    //         ),
    //       ),
    //     ),
    //   ));
    // }

    // return list;
    // return notesListController.activeNotes.map((e) {
    //   index++;
    //   return
    //   index++;
    // }).toList(growable: true);

    notesListController.getArchiveNotesList().asMap().forEach((index, _) {
      print('notesListController.getArchiveNotesList asMap called');
      HomeTaskItemModel homeTaskItemModel =
          notesListController.getArchiveNotesList()[index];
      // if (!notesListController.filteredNotesList[index].isArchived) {
      list.add(GetBuilder<NotesListController>(
        key: Key(homeTaskItemModel.key.toString()),
        builder: (logic) {
          print('Nested note Item get builder called');
          return notesListController.isSelectingList.value
              ? MultiSelectItem(
                  isSelecting: true,
                  // notesListController.multiSelectController.isSelecting,
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
                  confirmDismiss: (direction) async {
                    print('confirm dismiss called');
                    // return Future.value(false);
                    bool? result = await showConfirmationDialog(
                        notesListController, homeTaskItemModel);
                    if (result != null) {
                      print('not null');
                      return Future.value(result);
                    } else {
                      print('null');
                      return Future.value(false);
                    }
                  },
                  onDismissed: (direction) {
                    // int oldIndex = index;
                    // HomeTaskItemModel item = homeTaskItemModel;
                    // notesListController
                    //     .deleteNoteFromNotesList(homeTaskItemModel);
                    //
                    // //Delete from database after 3 seconds if user doesn't press undo
                    // Timer t = Timer(Duration(seconds: 3), () {
                    //   print('Time ran for ${item.title}');
                    //   notesListController.deleteNoteFromDatabase(item);
                    // });
                    //
                    // // SnackBarUtils.showGetXSnackBar(
                    // //     '${item.title} has been archived');
                    // Get.snackbar(
                    //   'Note Archived',
                    //   '${item.title} has been archived',
                    //   mainButton: TextButton(
                    //     onPressed: () {
                    //       //Cancel the timer. So it doesn't delete from database. Avoiding un-necessary write operations
                    //       t.cancel();
                    //       notesListController.undoNoteDelete(oldIndex, item);
                    //     },
                    //     child: Text('UNDO'),
                    //   ),
                    //   backgroundColor: Get.theme.accentColor,
                    //   isDismissible: false,
                    //   snackStyle: SnackStyle.FLOATING,
                    // );
                  },
                  child: InkWell(
                    onLongPress: () {
                      notesListController.setIsSelectingList(true);
                      notesListController.toggleSelectedIndex(index);
                    },
                    onTap: () {
                      Get.to(
                        () =>
                            AddTaskScreen(homeTaskItemModel: homeTaskItemModel),
                        transition: Transition.zoom,
                      );
                    },
                    borderRadius: BorderRadius.circular(8),
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
                  ),
                );
        },
      )
          // GetBuilder<NotesListController>(
          //
          //   init: NotesListController(),
          //   key: Key(
          //       notesListController.getArchiveNotesList()[index].key.toString()),
          //   builder: (notesListController) {
          //     // if (!notesListController.filteredNotesList[index].isArchived)
          //     return Dismissible(
          //       key: Key(notesListController
          //           .getArchiveNotesList()[index]
          //           .key
          //           .toString()),
          //       onDismissed: (direction) {
          //         notesListController.deleteNoteFromNotesList(
          //             notesListController.getArchiveNotesList()[index]);
          //
          //         //Delete from database after 3 seconds if user doesn't press undo
          //         Timer t = Timer(Duration(seconds: 3), () {
          //           print(
          //               'Time ran for ${notesListController.getArchiveNotesList()[index].title}');
          //           // notesListController.deleteNoteFromDatabase(
          //           //     notesListController.filteredNotesList[index]);
          //         });
          //
          //         Get.snackbar(
          //           'Note Archived',
          //           '${notesListController.getArchiveNotesList()[index]} has been archived',
          //           mainButton: TextButton(
          //             onPressed: () {
          //               //Cancel the timer. So it doesn't delete from database. Avoiding un-necessary write operations
          //               t.cancel();
          //               notesListController.undoNoteDelete(
          //                 notesListController.getArchiveNotesList()[index],
          //               );
          //             },
          //             child: Text('UNDO'),
          //           ),
          //           backgroundColor: Get.theme.accentColor,
          //           isDismissible: false,
          //           snackStyle: SnackStyle.FLOATING,
          //         );
          //       },
          //       child: NoteItem(
          //         homeTaskItemModel:
          //             notesListController.getArchiveNotesList()[index],
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

  Future<bool?> showConfirmationDialog(NotesListController notesListController,
      HomeTaskItemModel homeTaskItemModel) async {
    return Get.defaultDialog(
      radius: 8,
      title: 'Confirmation',
      middleText: 'This cannot be undone. Select an action for this note',
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            Get.back(result: true);
            notesListController.deleteNoteFromNotesList(
                homeTaskItemModel, false);
            notesListController.deleteNoteFromDatabase(homeTaskItemModel);
            SnackBarUtils.showGetXSnackBar('Note deleted',
                addBottomSpace: true);
          },
          child: Text('Delete'),
        ),
        // TextButton(
        //   onPressed: () {
        //     notesListController.archiveNote(homeTaskItemModel);
        //     Get.back(result: true);
        //     SnackBarUtils.showGetXSnackBar(
        //       'Note archived',
        //       addBottomSpace: true,
        //     );
        //   },
        //   child: Text('Archive'),
        // ),
        TextButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: Text('Cancel'),
        ),
      ],
      // cancel: TextButton(
      //   onPressed: () {
      //     notesListController.archiveNote(homeTaskItemModel);
      //     SnackBarUtils.showGetXSnackBar('Note archived');
      //     Get.back();
      //   },
      //   child: Text('Archive'),
      // ),
    );
  }

/*
  _getNotesList() {
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
                    //First of all delete from notes list
                    notesListController.deleteNoteFromNotesList(
                        notesListController.filteredNotesList[index]);

                    //Delete from database after 3 seconds if user doesn't press undo
                    Timer t = Timer(Duration(seconds: 3), () {
                      print(
                          'Time ran for ${notesListController.filteredNotesList[index]}');
                      // notesListController.deleteNoteFromDatabase(
                      //     notesListController.filteredNotesList[index]);
                    });

                    Get.snackbar(
                      'Note Archived',
                      '${notesListController.filteredNotesList[index]} has been archived',
                      mainButton: TextButton(
                        onPressed: () {
                          //Cancel the timer. So it doesn't delete from database. Avoiding un-necessary write operations
                          t.cancel();
                          notesListController.undoNoteDelete(
                            oldIndex
                            notesListController.filteredNotesList[index],
                          );
                        },
                        child: Text('UNDO'),
                      ),
                      backgroundColor: Get.theme.accentColor,
                      isDismissible: false,
                      snackStyle: SnackStyle.FLOATING,
                    );
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
*/

// Row buildAppBar(BuildContext context) {
//   return AppBarWithSearchAndIcon(showArchiveNotes: false,);
// }
}
