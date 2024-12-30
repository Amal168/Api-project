import 'package:api_project/MVVM/model/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Curd extends StatefulWidget {
  const Curd({super.key});

  @override
  State<Curd> createState() => _CurdState();
}

class _CurdState extends State<Curd> {
  final title = TextEditingController();
  final discription = TextEditingController();
  final edittitle = TextEditingController();
  final editdiscription = TextEditingController();
  final controller = Get.put(Controller());
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      body: Obx(
        () => controller.loadData.isTrue
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    reverse: false,
                    itemCount: controller.curdModelData.length,
                    itemBuilder: (context, index) {
                      final curditemdata = controller.curdModelData[index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Image.network(
                                  "https://pngimg.com/uploads/mickey_mouse/mickey_mouse_PNG27.png"),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(curditemdata.title.toString() ?? ""),
                                Text(curditemdata.description.toString() ?? ""),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      title.text =
                                          curditemdata.title.toString();
                                      discription.text =
                                          curditemdata.description.toString();
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Edit"),
                                            content: Form(
                                              key: formkey,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    controller: title,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "enter title";
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                        hintText: "Title",
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20))),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  TextFormField(
                                                    controller: discription,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "enter discription";
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                        hintText: "discription",
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20))),
                                                  )
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                    if (formkey.currentState!
                                                        .validate()) {
                                                      await controller
                                                          .updatedata(
                                                              controller
                                                                  .curdModelData[
                                                                      index]
                                                                  .id
                                                                  .toString(),
                                                              edittitle.text,
                                                              editdiscription
                                                                  .text,
                                                              context);
                                                    }
                                                  },
                                                  child: Text("Ok")),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Cancel"))
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () async {
                                      await controller.deleteData(
                                          controller.curdModelData[index].id
                                              .toString(),
                                          context);
                                      title.clear();
                                      discription.clear();
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.delete)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ))
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              useSafeArea: true,
              backgroundColor: Colors.grey,
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: title,
                            decoration: InputDecoration(
                                hintText: 'enter title',
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: discription,
                            decoration: InputDecoration(
                                hintText: 'enter description',
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          MaterialButton(
                            height: 50,
                            color: Colors.black,
                            minWidth: double.infinity,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () async {
                              Navigator.pop(context);
                              await controller.postData(
                                  title.text.toString().trim(),
                                  discription.text.trim(),
                                  context);
                              title.clear();
                              discription.clear();
                            },
                            child: Text(
                              'Add Data',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
