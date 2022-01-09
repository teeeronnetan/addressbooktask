Future<Task> getTask(String uid);
Future<Task> getAllTask();
Future<Task> deleteTask(String uid);
Future<Task> addTask(Map data);
Future<Task> editTask(String uid,Map data);