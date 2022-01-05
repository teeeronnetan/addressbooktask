class Address{
  final String uid;
  String fname;
  String lname;
  String phonenum;
  String addr;
  String birthdate;

  Address(this.uid, this.fname, this.lname, this.phonenum, this.addr, this.birthdate);
  //, this.lname, this.phonenum, this.addr, this.birthdate

  Map toJson() => {'uid': uid, 'fname': fname, 'lname':lname, 'phonenum':phonenum, 'addr':addr, 'birthdate':birthdate};
  
}