import 'package:bloc_eduction/modules/archive_task/archive_task_screen.dart';
import 'package:bloc_eduction/modules/done_task/done_task_screen.dart';
import 'package:bloc_eduction/modules/new_task/new_task_screen.dart';
import 'package:bloc_eduction/shared/component/component.dart';
import 'package:bloc_eduction/shared/component/cuibt/cubit.dart';
import 'package:bloc_eduction/shared/component/cuibt/state.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

import '../shared/component/constaint.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class home_layout extends StatelessWidget {
   home_layout({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => appcuit()..createdatabase(),
        child: BlocConsumer<appcuit, appstate>(
          builder: (BuildContext context, appstate state) {
            var cubit = appcuit.get(context);
            return Scaffold(
              key: cubit.Scaffoldkey,
              appBar: AppBar(title: Text(cubit.tites[cubit.curre])),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  //insetdata();
                  if (cubit.isbottomsheet) {
                    if (cubit.formkey.currentState!.validate()) {
                    cubit.insetdata(title:cubit.titelcontroal.text,  date: cubit.datecontroal.text,time: cubit.timecontroal.text,Status:'new');     
                    }
                  } else {       
                    cubit.isbottomsheet = true;
                    cubit.Scaffoldkey.currentState!.showBottomSheet((context) => 
                        Container(
                              height: 600,
                              width: double.infinity,
                              color: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Form(
                                  key: cubit.formkey,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        defaultFormField(
                                            label: 'Task Title',
                                            validation: (String value) {
                                              if (value.isEmpty) {
                                                return 'title must no be empty';
                                              }
                                              return null;
                                            },
                                            type: TextInputType.text,
                                            controller: cubit.titelcontroal,
                                            preffix: Icons.title),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        defaultFormField(
                                            onLapp: () {
                                              showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now())
                                                  .then((value) {
                                                cubit.timecontroal.text = value!
                                                    .format(context)
                                                    .toString();
                                              });
                                            },
                                            label: 'Task time',
                                            validation: (String value) {
                                              if (value.isEmpty) {
                                                return 'Time must no be empty';
                                              }
                                              return null;
                                            },
                                            type: TextInputType.datetime,
                                            controller: cubit.timecontroal,
                                            preffix: Icons.timelapse),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        defaultFormField(
                                            onLapp: () {
                                              showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: new DateTime(
                                                    2025,
                                                  )).then((value) {
                                                cubit.datecontroal.text =
                                                    DateFormat.yMMMd()
                                                        .format(value!);
                                              });
                                            },
                                            label: 'Task Date',
                                            validation: (String value) {
                                              if (value.isEmpty) {
                                                return 'Date must no be empty';
                                              }
                                              return null;
                                            },
                                            type: TextInputType.datetime,
                                            controller: cubit.datecontroal,
                                            preffix: Icons.date_range)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),elevation: 20.0
                            )
                        .closed
                        .then((value) {
                      cubit.changBottomSheetState(ishow: false,icon: Icons.edit);
                    });

 cubit.changBottomSheetState(ishow: true,icon: Icons.add);
                  }
                },
                child: Icon(cubit.flatIcon),
              ),
              body: state is ApploadDatebasestate
                  ? Center(child: CircularProgressIndicator())
                  : cubit.Screen[cubit.curre],
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.curre,
                onTap: (index) {
                  cubit.changeindex(index);
                  // setState(() {
                  //   curre = index;
                  // });
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: 'Task'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outline), label: 'Done'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined), label: 'Archived')
                ],
              ),
            );
          },
          listener: (BuildContext context, appstate state) {
            if(state is AppinsertDatebasestate){
                 Navigator.pop(context);
            }
          },
        ));
  }
}


