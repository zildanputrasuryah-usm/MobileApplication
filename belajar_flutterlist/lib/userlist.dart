import 'package:flutter/material.dart';
import 'package:belajar_flutterlist/userdata.dart';
import 'package:belajar_flutterlist/useritem.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer';

class UserList extends StatefulWidget {
  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  TextEditingController Nama = TextEditingController();

  TextEditingController Umur = TextEditingController();

  TextEditingController Email = TextEditingController();

  List<UserData> daftarUser = [
    UserData("Idris", 34, "idrez.mochamad@gmail.com"),
    UserData("Adi", 24, "adi@gmail.com"),
    UserData("Rizal", 33, "rizal.mochamad@gmail.com"),
  ];

  String btnSimpanText = "Simpan";
  String btnUbahText = "Ubah";
  Color btnSimpanWarna = Colors.blueAccent;
  Color btnUbahWarna = Colors.blueGrey;

  int indexDipilih = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: TextField(
                  controller: Nama,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Nama",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: TextField(
                  controller: Umur,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Umur",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: TextField(
                  controller: Email,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () {
                    try {
                      if (Nama.text.isEmpty ||
                          Umur.text.isEmpty ||
                          Email.text.isEmpty)
                        throw new Exception("Isian tidak boleh kosong");

                      if (btnSimpanText == "Simpan") {
                        daftarUser.add(UserData(
                            Nama.text, int.parse(Umur.text), Email.text));
                      } else {
                        UserData userData = daftarUser[indexDipilih];
                        userData.nama = Nama.text;
                        userData.umur = int.parse(Umur.text);
                        userData.email = Email.text;

                        btnSimpanText = "Simpan";
                        btnSimpanWarna = Colors.blueAccent;
                      }
                      setState(() {
                        UserData;
                      });

                      Nama.text = "";
                      Umur.text = "";
                      Email.text = "";
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: '$e',
                      );
                    }
                    inspect(daftarUser);
                  },
                  child: Text(btnSimpanText),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(150, 75),
                      backgroundColor: btnSimpanWarna),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: ValueKey(daftarUser[index]),
                        child: InkWell(
                          child: UserItem(daftarUser[index]),
                          onTap: () {
                            Nama.text = daftarUser[index].nama;
                            Umur.text = daftarUser[index].umur.toString();
                            Email.text = daftarUser[index].email;

                            btnSimpanText = btnUbahText;
                            btnSimpanWarna = btnUbahWarna;

                            indexDipilih = index;

                            setState(() {
                              btnSimpanText;
                              btnSimpanWarna;
                            });
                          },
                        ),
                        background: Container(
                          padding: EdgeInsets.only(left: 10),
                          color: Colors.red,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        secondaryBackground: Container(
                          padding: EdgeInsets.only(left: 10),
                          color: Colors.white,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            daftarUser.removeAt(index);

                            setState(() {
                              daftarUser;
                            });
                          }
                        },
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm"),
                                  content:
                                      const Text("Apakah yakin akan menghapus"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text("Hapus")),
                                    ElevatedButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: const Text("Batal")),
                                  ],
                                );
                              },
                            );
                          } else {
                            return false;
                          }
                        },
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: daftarUser.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}