


import 'package:bloc_eduction/shared/component/cuibt/cubit.dart';
import 'package:flutter/material.dart';

import '../../shared/component/component.dart';
import '../../shared/component/cuibt/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class archive_task_screen extends StatelessWidget {
   archive_task_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appcuit, appstate>(
      listener: (context, state) {
        
      },
      builder: (context, state) {
      var cubit = appcuit.get(context).archivetasks;
        return buildtask_view(Task: cubit);
      },
    );  }

  }
