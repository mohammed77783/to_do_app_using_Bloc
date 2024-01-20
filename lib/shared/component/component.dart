import 'package:bloc_eduction/shared/component/cuibt/cubit.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  required String text,
  Color textColor = Colors.white,
  double height = 56.0,
  double width = double.infinity,
  required VoidCallback onClick,
  double radius = 6.0,
  Color buttonColor = Colors.teal,
  bool isCapitalize = false,
}) =>
    Container(
      width: width,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
      child: MaterialButton(
        height: height,
        color: buttonColor,
        onPressed: () {
          onClick();
        },
        child: Text(
          isCapitalize ? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );

Widget defaultFormField(
        {required String label,
        required Function validation,
        final double? radius = 5.0,
        required TextInputType type,
        required TextEditingController? controller,
        final bool isPassword = false,
        Function? onSubmit,
        Function? onchange,
        IconData? suffix,
        IconData? preffix,
        Function? suffexpress,
        VoidCallback? onLapp,
        bool isenable = true}) =>
    TextFormField(
      enabled: isenable,
      onTap: onLapp,
      obscureText: isPassword,
      controller: controller,
      onChanged: (value) => onchange,
      keyboardType: type,
      validator: (value) => validation(value),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              radius!,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          labelText: label,
          suffixIcon: suffix != null
              ? IconButton(onPressed: () => suffexpress, icon: Icon(suffix))
              : null,
          prefix: preffix != null
              ? Padding(
                  padding: EdgeInsets.only(right: 10), child: Icon(preffix))
              : null),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget buildSeparator() => Container(
      height: 1.0,
      width: double.infinity,
      color: Colors.grey[300],
    );

Widget builtaskitem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        appcuit.get(context).DeleteDate(id: model['id']);
      },
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text("${model['time']}"),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${model['title']}",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            IconButton(
                icon: Icon(
                  Icons.check_box,
                  color: Colors.green,
                ),
                onPressed: () {
                  appcuit
                      .get(context)
                      .updateDate(status: 'archive', id: model['id']);
                }),
            IconButton(
                icon: Icon(
                  Icons.archive,
                  color: Colors.black45,
                ),
                onPressed: () {
                  appcuit
                      .get(context)
                      .updateDate(status: 'done', id: model['id']);
                })
          ],
        ),
      ),
    );

Widget buildtask_view({required List<Map> Task}) => Task.length > 0
    ? ListView.separated(
        itemBuilder: (contex, index) => builtaskitem(Task[index], contex),
        separatorBuilder: (context, i) => Padding(
          padding: const EdgeInsetsDirectional.only(start: 10),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        itemCount: Task.length,
      )
    : Center(
        child: Column(
        children: [
          Icon(
            Icons.menu,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            'There is not Task please add ',
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ));
