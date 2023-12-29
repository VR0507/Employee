import 'package:floor/floor.dart';
import 'database_model.dart';

@dao
abstract class EmployeeDao {
  @Query('SELECT * FROM employee')
  Future<List<Employee>> findAllEmployee();

  // @Query('Select * from tiffin order by id desc limit 1')
  // Future<Employee?> getMaxTodo();
  //
  // @Query('SELECT * FROM tiffin order by id desc')
  // Stream<List<Employee>> fetchStreamData();

  @insert
  Future<void> insertEmployee(Employee employee);

  @Query("delete from employee where id = :id")
  Future<void> deleteEmployee(int id);

  @update
  Future<void> updateEmployee(Employee employee);

  // @Query("delete from employee where id = :id")
  // Future<void> updateEmployee(int id,Employee employee);

  @delete
  Future<int> deleteAll(List<Employee> list);
}
