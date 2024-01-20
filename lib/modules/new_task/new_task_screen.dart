import 'package:bloc_eduction/shared/component/constaint.dart';
import 'package:bloc_eduction/shared/component/cuibt/cubit.dart';
import 'package:bloc_eduction/shared/component/cuibt/state.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/component/component.dart';

class new_task_screen extends StatelessWidget {

   new_task_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appcuit, appstate>(
      listener: (context, state) {
      },
      builder: (context, state) {
       var cubit = appcuit.get(context).newtasks;
        return buildtask_view(Task:cubit);
               },
    );  }
}
