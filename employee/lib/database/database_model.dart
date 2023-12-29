import 'package:floor/floor.dart';

@Entity(tableName: 'employee')
class Employee {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'name')
  final String? name;
  @ColumnInfo(name: 'email')
  final String? email;
  @ColumnInfo(name: 'image')
  final String? image;

  @ignore
  bool isSelect = false;

  Employee({
    this.id,
    this.name,
    this.email,
    this.image,
  });
}
