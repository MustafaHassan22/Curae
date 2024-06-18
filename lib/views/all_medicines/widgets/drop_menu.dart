import 'package:flutter/material.dart';


class DropMenuWidget extends StatelessWidget {
  const DropMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
          return PopupMenuButton(
            color:  Color.fromARGB(255, 244, 250, 255),
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            offset: Offset(0, 45),
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry>[

                PopupMenuItem(
                    enabled: false,
                    child: ListTile(
                      leading: Icon(Icons.logout, color: Color(0xFF4E97C5)),
                      title: Text('LogOut', style: TextStyle(fontSize: 16, color: Color(0xFF4E97C5))),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                ),
              ];
            },
          );

  }
}