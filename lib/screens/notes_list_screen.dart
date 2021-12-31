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
import 'package:noteapp/utils/reorderable_items_view.dart';
import 'package:noteapp/utils/snack_bar_utils.dart';
import 'package:share_plus/share_plus.dart';

class NotesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notesListController = Get.find<NotesListController>();
    notesListController
        .initSelectionSize(notesListController.getActiveNotesList().length);
    // Get.changeTheme(ThemeData.dark());
    // Get.find();
    List<Widget> notesList = <Widget>[];
    return WillPopScope(
      onWillPop: () {
        if (notesListController.isSelectingList.value) {
          notesListController.resetSelection();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: SafeArea(
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
                                            selectedListItems
                                                .forEach((element) {
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
                          archiveNotesList(
                              selectedIndexes, notesListController);
                        },
                        onDeleteClicked: (List<int> selectedIndexes) {
                          showDeleteNotesConfirmation(
                              selectedIndexes, notesListController);
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
                          scrollController:
                              notesListController.scrollController,
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
                          ),
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDeleteNotesConfirmation(
      List<int> selectedIndexes, NotesListController notesListController) {
    Get.defaultDialog(
      radius: 8,
      title: 'Confirmation',
      middleText: 'This cannot be undone. Are you sure to delete all notes?',
      confirm: TextButton(
        onPressed: () {
          List<HomeTaskItemModel> selectedListItems = selectedIndexes
              .map((index) => notesListController.getActiveNotesList()[index])
              .toList();
          selectedListItems.forEach((element) {
            notesListController.deleteNoteFromNotesList(element, false);
            notesListController.deleteNoteFromDatabase(element);
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
      ),
    );
  }

  void shareNotes(
      List<int> selectedIndexes, NotesListController notesListController) {
    List<HomeTaskItemModel> selectedListItems = selectedIndexes
        .map((index) => notesListController.getActiveNotesList()[index])
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

  void archiveNotesList(
      List<int> selectedIndexes, NotesListController notesListController) {
    List<HomeTaskItemModel> selectedListItems = selectedIndexes
        .map((index) => notesListController.getActiveNotesList()[index])
        .toList();
    selectedListItems.forEach((element) {
      notesListController.archiveNote(element, false);
    });
    notesListController.resetSelection();
    notesListController.filteredNotesList.refresh();
    notesListController.update();
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
          // return notesListController.multiSelectController.isSelecting
          return notesListController.isSelectingList.value
              ? MultiSelectItem(
                  isSelecting: notesListController.isSelectingList.value,
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
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(8),
                        child: NoteItem(
                          homeTaskItemModel: homeTaskItemModel,
                          onNoteItemClicked:
                              (HomeTaskItemModel homeTaskItemModel) {},
                        ),
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
                  // dismissThresholds: {DismissDirection.horizontal: 0.9},
                  onDismissed: (direction) {
                    // showConfirmationDialog(
                    //     notesListController, homeTaskItemModel);
                    // notesListController.archiveNote(homeTaskItemModel);
                    // print('On dismissed called');
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
                      onNoteItemClicked:
                          (HomeTaskItemModel homeTaskItemModel) {},
                    ),
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
        TextButton(
          onPressed: () {
            notesListController.archiveNote(homeTaskItemModel);
            Get.back(result: true);
            SnackBarUtils.showGetXSnackBar(
              'Note archived',
              addBottomSpace: true,
            );
          },
          child: Text('Archive'),
        ),
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
}
