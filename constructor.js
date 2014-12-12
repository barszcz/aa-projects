function Cat (name, owner){
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function(){
  return this.owner + " loves " + this.name;
}



Cat.prototype.cuteStatement = function(){
  return "Everyone loves " + this.name;
}




function Student(fname, lname){
  this.name = fname + " " + lname;
  this.courses = [];
}

function Course(cname, dept, credz) {
  this.cname = cname;
  this.dept = dept;
  this.credz = credz;
  this.students = [];
}

Student.prototype.enroll = function (course) {
  this.courses = this.courses.concat(course);
  course.students = course.students.concat(this);
}

Student.prototype.course_load = function () {
  var dept_hash = {}
  this.courses.forEach(function (el) {
    if (dept_hash[el.dept]) {
      dept_hash[el.dept] += el.credz;
    }
    else {
      dept_hash[el.dept] = el.credz;
    }
  })
  return dept_hash;
}

Course.prototype.add_student = function (student) {
  student.enroll(this);
}
