
//list of sortBy values
List<String> getEmployeeSortByValues() {
  return [
    'createdAt',
    'name',
    'id',
    'email',
    'department',
    'phone',
    'birthday',
    'country',
  ];
}
// List of current filters
List<String> getEmployeeFilters() {
  return [
    'name',
    'email',
    'department',
    'phone',
    'country',
  ];
}
//this is an extension to capitalize the string

extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }
}