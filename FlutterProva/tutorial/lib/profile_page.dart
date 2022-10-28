import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart'; // package for slidable item

const int itemCount = 20;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        return Slidable(
          // Specify a key if the Slidable is dismissible.
          key: ValueKey(index),

          closeOnScroll: true,

          // The start action pane is the one at the left or the top side.
          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // A pane can dismiss the Slidable.
            // dismissible: DismissiblePane(onDismissed: () {}),

            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                flex:
                    1, // changing 'flex' the SlidableAction Widget become bigger
                onPressed: (BuildContext context) {
                  debugPrint("SHARING");
                },
                backgroundColor: const Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.share,
                label: 'Share',
              ),
              SlidableAction(
                flex:
                    1, // changing 'flex' the SlidableAction Widget become bigger
                onPressed: (BuildContext context) {
                  debugPrint("SAVING");
                },
                backgroundColor: const Color(0xFF0392CF),
                foregroundColor: Colors.white,
                icon: Icons.save,
                label: 'Save',
              ),
            ],
          ),

          // The end action pane is the one at the right or the bottom side.
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.25,
            children: [
              // SlidableAction(
              //   flex: 1, // changing 'flex' the SlidableAction Widget become bigger
              //   onPressed: (BuildContext context) {
              //     debugPrint("ARCHIVING");
              //   },
              //   backgroundColor: const Color(0xFF7BC043),
              //   foregroundColor: Colors.white,
              //   icon: Icons.archive,
              //   label: 'Archive',
              // ),
              SlidableAction(
                flex: 1, // changing 'flex' the SlidableAction Widget become bigger
                onPressed: (BuildContext context) {
                  debugPrint("DELETING");
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),

          // The child of the Slidable is what the user sees when the
          // component is not dragged.
          child: ListTile(
              title: Text("item $index"),
              leading: const Icon(Icons.person),
              trailing: const Icon(Icons.select_all),
              onTap: () {
                debugPrint("Item $index");
              }),
        );
      },
    );
  }
}
