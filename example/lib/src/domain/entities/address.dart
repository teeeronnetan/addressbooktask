class Address{
  final String uid;
  String fname;
  String mname;
  String lname;
  String phonenum;
  String addr;
  String birthdate;
  int age;

  Address(this.uid, this.fname, this.mname, this.lname, this.phonenum, this.addr, this.birthdate, this.age);

  Map<String, dynamic> toJson() => {'fname': fname, 'mname': mname, 'lname':lname, 'phonenum':phonenum, 'addr':addr, 'birthdate':birthdate, 'age':age};
  
}