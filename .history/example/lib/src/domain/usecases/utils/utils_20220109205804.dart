int calculateAge(String birthdate) {
  //formula
  final currentDate = DateTime.now();
  final birthDateTime = DateTime.parse(birthdate);
  var age = currentDate.year - birthDateTime.year;
  var month1 = currentDate.month;
  var month2 = birthDateTime.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    var day1 = currentDate.day;
    var day2 = birthDateTime.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}
