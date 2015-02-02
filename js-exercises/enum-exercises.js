Array.prototype.each = function(func) {
  for (i = 0; i < this.length; i++ ) {
    func(this[i]);
  };
};

var times_two = function(n) {
  return (n * 2);
};


Array.prototype.my_map = function(func) {
  var result = [];
  var push_eval = function(el) {
    result.push(func(el));
  };

  this.each(push_eval);

  return result;
};

Array.prototype.my_inject = function(func) {
  var acc = this[0];

  var inject_eval = function(el) {
    acc = func(acc, el);
  };

  this.slice(1).each(inject_eval);
  return acc;
};

var plus = function(x, y) {
  return x + y;
}

var times = function(x, y) {
  return x * y;
}



console.log([1,2,3,4].my_map(times_two));
