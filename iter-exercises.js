Array.prototype.bubble_sort = function() {
  var sorted = false;
  var tmp
  while (!sorted) {
    sorted = true;
    for (i=0; i < this.length; i++) {
      for (j=1; j < this.length; j++) {
        if (this[j - 1] > this[j]) {
        tmp = this[j];
        this[j] = this[j-1];
        this[j-1] = tmp;
        sorted = false;
        }
      }
    }
  }
}

var substrings = function(str){
  result = []
  for (i =0; i<str.length; i++){
    for (j = i+1; j<=str.length; j++){
      result.push(str.slice(i,j));
    }
  }
  return result;
}


console.log(substrings("cat"));
