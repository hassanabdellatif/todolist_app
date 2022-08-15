import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  late Database database;

  String selectedRepeat = 'None';
  String selectedRemind = '10 min before';
  List<String> remindList = [
    '10 min before',
    '30 min before',
    '1 hour before',
    '1 day before'
  ];
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController remindController = TextEditingController();
  TextEditingController colorController = TextEditingController();

  List<Map> newTasks = [];
  List<Map> completedTasks = [];
  List<Map> uncompletedTasks = [];
  List<Map> favoriteTasks = [];
  List<Map> scheduleTasks = [];

  void initialDatabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'tasks.db');
    debugPrint('AppDatabaseInitialized');
    // Open the database
    openAppDatabase(path: path);
    emit(AppDatabaseInitializedState());
  }

  void openAppDatabase({required String path}) async {
    openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        Batch batch = db.batch();
        batch.execute(
          '''
            CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            date TEXT,
            start_time TEXT,
            end_time TEXT,
            remind TEXT,
            color TEXT,
            status Text
            )
          ''',
        );
        await batch.commit();
        debugPrint('Table Created');
      },
      onOpen: (Database db) {
        debugPrint('AppDatabaseOpened');
        database = db;
        getTasksData();
      },
    );
  }

  // Get the records
  void getTasksData() async {
    newTasks = [];
    completedTasks = [];
    uncompletedTasks = [];
    favoriteTasks = [];
    emit(AppDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then(
      (value) {
        debugPrint('Task Data Fetched');
        for (var element in value) {
          if (element['status'] == 'new') {
            newTasks.add(element);
          } else if (element['status'] == 'completed') {
            completedTasks.add(element);
          } else if (element['status'] == 'uncompleted') {
            uncompletedTasks.add(element);
          } else if (element['status'] == 'favorite') {
            favoriteTasks.add(element);
          }
        }
        scheduleTasks = value;
        emit(AppDatabaseTasksState());
      },
    );
  }

  // Insert some records in a transaction
  void insertTaskData() {
    database.transaction(
      (txn) async {
        txn.rawInsert(
          '''
            INSERT INTO tasks('title','description','date','start_time','end_time','remind','color','status')
            VALUES("${titleController.text}","${descriptionController.text}","${dateController.text}","${startTimeController.text}",
            "${endTimeController.text}","${remindController.text}","${colorController.text}","new")
          ''',
        );
      },
    ).then(
      (value) {
        debugPrint('Task Data Inserted');
        titleController.clear();
        descriptionController.clear();
        dateController.clear();
        startTimeController.clear();
        endTimeController.clear();
        remindController.clear();
        colorController.clear();
        getTasksData();
        emit(AppDatabaseTaskCreatedState());
      },
    );
  }

  // Update some record
  void updateTaskData({required int? id}) async {
    database.rawUpdate(
      '''
        UPDATE tasks SET 
        title = "${titleController.text}",
        description = "${descriptionController.text}",
        date = "${dateController.text}",
        start_time = "${startTimeController.text}",
        end_time = "${endTimeController.text}",
        remind = "${remindController.text}",
        color = "${colorController.text}"
        WHERE id = $id
      ''',
    ).then(
      (value) {
        titleController.clear();
        descriptionController.clear();
        dateController.clear();
        startTimeController.clear();
        endTimeController.clear();
        remindController.clear();
        colorController.clear();
        debugPrint('Task Data Updated');
        getTasksData();
        emit(AppDatabaseTaskUpdatedState());
      },
    );
  }

  void updateTaskStatus({required String status, required int id}) {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      [status, id],
    ).then(
      (value) {
        debugPrint('Task Status Updated');
        getTasksData();
        emit(AppDatabaseTaskStatusUpdatedState());
      },
    );
  }

  // Delete a record
  void deleteTaskData({required int id}) {
    database.rawDelete('DELETE FROM tasks WHERE id = $id').then(
      (value) {
        debugPrint('Task Data Deleted');
        getTasksData();
        emit(AppDatabaseTaskDeletedState());
      },
    );
  }

  bool isDark = false;

  void changeAppMode() {
    isDark = !isDark;
    emit(AppChangeModeState());
  }
}
