Array.prototype.uniq = function() {
  var newArr = [];
  for(i =0; i < this.length; i++)
    {
      present = false;
      for(j = 0; j < newArr.length; j++)
        {
          if (newArr[j] === this[i])
            {
              present = true;
            }
        }

      if (!present)
        {
          newArr.push(this[i]);
        }
    }
  return newArr;
};

Array.prototype.twoSum = function() {
  var result = [];
  for(i=0; i< this.length; i++)
  {
    for(j=i+1; j<this.length; j++)
    {
      if (this[i] + this[j] === 0)
      {
        result.push([i,j]);
      }
    }
  }

  return result;
};

Array.prototype.my_transpose = function(){
  var result, temp_result;
  result = [];
  for(i=0; i<this.length; i++){
    temp_result = [];
    for(j=0; j<this.length; j++){
      temp_result.push(this[j][i]);
    };
    result.push(temp_result);
  };
  return result;

};







console.log([[1,2,3],[4,5,6],[7,8,9]].my_transpose())
// console.log([1,3,-7,7,9].twoSum())
// console.log([-1, 0, 2, -2, 1].twoSum())
