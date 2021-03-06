import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:sary_assessment_app/functions/crud.dart';
import 'package:sary_assessment_app/model/item.dart';
import 'package:sary_assessment_app/widgets/custom_toast_message.dart';

import 'custom_alert.dart';

class ElavatedFloatingButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isTransaction;

  final Item? item;

  const ElavatedFloatingButton(
      Key? key, this.label, this.icon, this.isTransaction,
      [this.item])
      : super(key: key);

  @override
  State<ElavatedFloatingButton> createState() => _ElavatedFloatingButtonState();
}

class _ElavatedFloatingButtonState extends State<ElavatedFloatingButton> {
  // late TextEditingController _c;
  CRUD crud = CRUD();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return widget.isTransaction == true
        ? SizedBox(
            height: 50,
            width: 150,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  primary: Colors.indigo,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {},
              icon: Icon(widget.icon),
              label: Text(widget.label),
            ),
          )
        : widget.label == "Add Item"
            ? SizedBox(
                height: 50,
                width: screenWidth - 30,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    CustomeAlertState().addAlert(context, "a");
                    // addAlert(context);
                  },
                  icon: Icon(widget.icon),
                  label: Text(widget.label),
                ),
              )
            : SizedBox(
                height: 50,
                width: 110,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    if (widget.label == "Add") {
                      context.read<CRUD>().addItem(
                          widget.item?.name ?? "",
                          widget.item?.sku ?? "",
                          widget.item?.desc ?? "",
                          widget.item?.price ?? 0.0);
                      CustomToastMessageState()
                          .toastMessage(context, "New Item is added");
                    } else if (widget.label == "Update") {
                      context.read<CRUD>().editItem(
                          widget.item!,
                          widget.item?.name ?? "",
                          widget.item?.sku ?? "",
                          widget.item?.desc ?? "",
                          widget.item?.price ?? 0.0);
                      CustomToastMessageState()
                          .toastMessage(context, "Item has been updated");
                    } else if (widget.label == "Delete") {
                      context.read<CRUD>().deleteItem(widget.item!);
                      CustomToastMessageState()
                          .toastMessage(context, "Item has been deleted");
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(widget.icon),
                  label: Text(widget.label),
                ));
  }
}
