import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noteapp/constant/constant.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  bool? checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/bck btn.svg',
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/Vector.svg',
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/Vector-1.svg',
              ),
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Title Here',
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  isDense: true,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.add),
                label: Text('Add Item'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              TaskCheckItem(
                value: true,
                title: 'Item 1',
                onChanged: (newValue) {},
                onDownloadClicked: () {},
                onDeleteClicked: () {},
              ),
              Divider(),
              ElevatedButton(
                onPressed: () {},
                child: Text('Done'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              TaskCheckItem(
                value: checkBoxValue,
                title: 'Item 2',
                onChanged: (newValue) {
                  setState(() {
                    checkBoxValue = newValue;
                  });
                  print(newValue);
                },
                onDownloadClicked: () {},
                onDeleteClicked: () {},
              ),
              Divider(),
              SizedBox(
                height: size.height * 0.02,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('ADD TASK'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TaskCheckItem extends StatelessWidget {
  final bool? value;
  final String title;
  final void Function(bool?) onChanged;
  final void Function() onDownloadClicked, onDeleteClicked;

  TaskCheckItem(
      {required this.value,
      required this.title,
      required this.onChanged,
      required this.onDownloadClicked,
      required this.onDeleteClicked});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      activeColor: kPrimaryColor,
      dense: true,
      contentPadding: EdgeInsets.all(0),
      controlAffinity: ListTileControlAffinity.leading,
      tristate: true,
      title: Text(
        '$title',
        style: TextStyle(fontSize: 16),
      ),
      secondary: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onDownloadClicked,
            icon: SvgPicture.asset(
              'assets/icons/download.svg',
            ),
          ),
          IconButton(
            onPressed: onDeleteClicked,
            icon: SvgPicture.asset(
              'assets/icons/bx_bxs-trash-alt.svg',
            ),
          ),
        ],
      ),
      value: value,
      // onChanged: (newValue) {
      //   print(newValue);
      //   onChanged(newValue);
      // },
      onChanged: (newValue) {
        onChanged(newValue);
      },
    );
  }
}
