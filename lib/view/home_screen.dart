import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_with_adapter/database/db.dart';
import 'package:hive_with_adapter/model/notes_model.dart';
import 'package:hive_with_adapter/view/widgets/containercard.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  var box = Hive.box<notesmodel>('notebox');
  bool isediting = false;

  int selectedIndex = 0;
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  List mylist = [];
  @override
  void initState() {
    mylist = box.keys.toList();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          bottomsheet(context, 0);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Note App",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
              mylist.length,
              (index) => Containercard(
                    title: box.get(mylist[index])!.title,
                    description: box.get(mylist[index])!.description,
                    date: box.get(mylist[index])!.date,
                    color: box.get(mylist[index])!.color,
                    ondeleteTap: () {
                      box.delete(mylist[index]);
                      mylist = box.keys.toList();
                      setState(() {});
                    },
                    onedittap: () {
                      bottomsheet(context, mylist[index]);
                      titlecontroller.text = box.get(mylist[index])!.title;
                      descriptioncontroller.text =
                          box.get(mylist[index])!.description;
                      datecontroller.text = box.get(mylist[index])!.date;
                      selectedIndex = index;

                      isediting = true;
                    },
                  )),
        ),
      ),
    );
  }

  Future<dynamic> bottomsheet(BuildContext context, int? key) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, insetState) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    children: [
                      Title(
                          color: Colors.black,
                          child: Text(
                            "Add a note",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: titlecontroller,
                          decoration: InputDecoration(
                              label: Text("Title"),
                              border:
                                  OutlineInputBorder(borderSide: BorderSide())),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 200,
                          child: TextFormField(
                            expands: true,
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.top,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: descriptioncontroller,
                            decoration: InputDecoration(
                                label: Text("Descriptions"),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide())),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: datecontroller,
                          decoration: InputDecoration(
                              label: Text("Date"),
                              suffixIcon: Icon(Icons.calendar_month_outlined),
                              border:
                                  OutlineInputBorder(borderSide: BorderSide())),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(
                            database.colors.length,
                            (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  selectedIndex = index;
                                  setState(() {});
                                  insetState(
                                    () {},
                                  );
                                },
                                child: Container(
                                  height: selectedIndex == index ? 55 : 50,
                                  width: selectedIndex == index ? 55 : 50,
                                  decoration: BoxDecoration(
                                      color: database.colors[index]
                                          .withOpacity(.5),
                                      border: Border.all(
                                          color: index == selectedIndex
                                              ? database.colors[index]
                                              : database.colors[index]
                                                  .withOpacity(.5),
                                          width: 2),
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black)),
                              onPressed: () {
                                if (titlecontroller.text.isNotEmpty &&
                                    descriptioncontroller.text.isNotEmpty &&
                                    datecontroller.text.isNotEmpty) {
                                  if (isediting) {
                                    box.put(
                                        key,
                                        notesmodel(
                                            title: titlecontroller.text,
                                            description:
                                                descriptioncontroller.text,
                                            date: datecontroller.text,
                                            color: selectedIndex));
                                    isediting = false;
                                    mylist = box.keys.toList();
                                    titlecontroller.clear();
                                    descriptioncontroller.clear();
                                    datecontroller.clear();
                                    Navigator.pop(context);
                                    setState(() {});
                                  } else {
                                    box.add(
                                      notesmodel(
                                          title: titlecontroller.text,
                                          description:
                                              descriptioncontroller.text,
                                          date: datecontroller.text,
                                          color: selectedIndex),
                                    );
                                    mylist = box.keys.toList();

                                    titlecontroller.clear();
                                    descriptioncontroller.clear();
                                    datecontroller.clear();
                                    Navigator.pop(context);
                                    setState(() {});
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Please add details")));

                                  Navigator.pop(context);
                                }
                              },
                              child: isediting ? Text("Edit") : Text("Save")),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black)),
                              onPressed: () {
                                Navigator.pop(context);
                                isediting = false;
                              },
                              child: Text("Cancel"))
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
