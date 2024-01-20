
import 'package:bloc_eduction/modules/archive_task/archive_task_screen.dart';
import 'package:bloc_eduction/modules/done_task/done_task_screen.dart';
import 'package:bloc_eduction/modules/new_task/new_task_screen.dart';
import 'package:bloc_eduction/shared/component/constaint.dart';
import 'package:bloc_eduction/shared/component/cuibt/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
class appcuit extends Cubit<appstate>{
appcuit():super(appinitial());
  
  static appcuit get(context)=> BlocProvider.of(context);

List<Widget> Screen = [
    new_task_screen(),
    archive_task_screen(),
    done_task_screen()
  ];

  Database? database;
   var  formkey = GlobalKey<FormState>();
  List<String> tites = ['add', 'archive', 'done'];
  var Scaffoldkey = GlobalKey<ScaffoldState>();
  IconData flatIcon = Icons.add;
  var titelcontroal = TextEditingController();
  var datecontroal = TextEditingController();
  var timecontroal = TextEditingController();
  int curre = 0;
  bool isbottomsheet = false;
 List <Map> newtasks=[];
  List <Map> donetasks=[];
   List <Map> archivetasks=[];
void changeindex(int index){
  curre=index;
emit(appchangeBottomNavBarstate());
}
 void createdatabase()  {

  openDatabase("todo.db", version: 1,
        onCreate: (database, version) 
        {
      database.execute(
              'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date Text, time TEXT,Status TEXT)')
          .then((value) {
        print('table created ');
        
      }).catchError((erre) {
        print('========================================================');
        print('${erre.toString()}');
      });
    }, 
    onOpen: (database) {
getdata(database);
    }).then((value){
      this.database=value;
      emit(AppCreateDatebasestate());
    });
  }

void updateDate({required String status,required int id}) async{
  database!.rawUpdate(
    'UPDATE Tasks SET Status = ? WHERE id = ?',
    ['${status}','${id}']).then((value) {
     
emit(Appupdatebasestate());
 getdata(database);
    });
}


void DeleteDate({required int id}) async{
database!
    .rawDelete('DELETE FROM Tasks WHERE id = ?', ['${id}']).then((value) {
     emit(Appdeletebasestate());
 getdata(database); 
    },);
     

}



   insetdata({required String title,required String date,required String time,required String Status}) 
   async {
  
    await database!.transaction((txn)
    => txn.rawInsert('INSERT INTO Tasks(title,date,time,Status) VALUES ("${title}","${date}","${time}","${Status}")')
          .then((value){
             getdata(database);
               emit(AppinsertDatebasestate());
          })
          .catchError((error) {
        print('error happent ${error.toString()}');
      })
       
       );
    
  }



void getdata(database) async{
  emit(ApploadDatebasestate());
return await database.rawQuery('Select * from Tasks').then((value){
  newtasks=[];
  donetasks=[];
archivetasks=[];

value.forEach((Element){

if(Element['Status']=='new'){
newtasks.add(Element);
}else if(Element['Status']=='done'){
donetasks.add(Element);
} else archivetasks.add(Element);
});
 emit(AppgetDatebasestate());
});
}


void changBottomSheetState({required bool ishow,required IconData icon})
{
  isbottomsheet=ishow;
  flatIcon=icon;
  emit(appchangeBottomsheet());
}

}