import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:noteapp/components/no_notes_found.dart';
import 'package:noteapp/components/note_item.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:noteapp/controllers/notes_list_controller.dart';
import 'package:noteapp/models/home_task_item_model.dart';
import 'package:noteapp/screens/add_task_screen.dart';
import 'package:noteapp/screens/layout_screen.dart';

class NotesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notesListController = Get.find<NotesListController>();
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(bottom: 40),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 4.h,
            ),
            buildAppBar(),
            SizedBox(
              height: 12.h,
            ),
            Flexible(
              child: GetBuilder<NotesListController>(builder: (controller) {
                return controller.filteredNotesList
                        .where((element) => !element.isArchived)
                        .toList()
                        .isEmpty
                    ? NoNotesFound()
                    : StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        itemCount: notesListController.filteredNotesList.length,
                        itemBuilder: (BuildContext context, int index) =>
                            GetBuilder<NotesListController>(
                          builder: (controller) {
                            if (!notesListController
                                .filteredNotesList[index].isArchived)
                              return Dismissible(
                                key: Key(controller.filteredNotesList[index].key
                                    .toString()),
                                onDismissed: (direction) {
                                  controller.archiveNote(
                                      controller.filteredNotesList[index]);
                                },
                                child: NoteItem(
                                  homeTaskItemModel:
                                      controller.filteredNotesList[index],
                                ),
                              );
                            else
                              return Container();
                          },
                        ),
                        staggeredTileBuilder: (int index) =>
                            StaggeredTile.fit(1),
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                      );
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

  Row buildAppBar() {
    final notesListController = Get.find<NotesListController>();
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () {
            Get.to(() => LayoutScreen());
          },
          icon: SvgPicture.asset('assets/images/menu_icon.svg'),
        ),
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
                        notesListController.onSearched('', false);
                      }
                    },
                    child: Icon(
                      notesListController.isSearching.value
                          ? Icons.cancel_outlined
                          : Icons.search,
                      color: kNavbarColor,
                    ),
                  ),
                ),
                border: InputBorder.none,
                hintText: "Search notes",
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
