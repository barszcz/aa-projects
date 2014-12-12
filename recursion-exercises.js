
var range = function(start, end){
  if (end < start){
    return [];
  }
  else if (start == end){
    return [start];
  }
  else{
    return [start].concat(range(start+1, end));
  }
}
var sum_iter = function(arr){
  var result = 0;

  for (i=0; i<arr.length; i++){
    result += arr[i];
  }
  return result;
}

var sum_recursive = function(arr) {
  if (arr.length === 1) {
    return arr[0];
  }
  else {
    return arr[0] + sum_recursive(arr.slice(1));
  };
}

var exp1 = function(base, exp) {
  if (exp === 0) {
    return 1;
  }
  else {
    return (base * exp1(base, exp-1));
  }
}

var exp2 = function (base, exp) {
  var result;

  if (exp === 0) {
    return 1;
  }
  else if (exp === 1){
    return base;
  }
  else if (exp % 2 === 0) {
    result = exp2(base, (exp / 2))
    return (result * result)
  }
  else {
    result = exp2(base, ((exp - 1) / 2));
    return base * result * result;
  }
}

var fibs_iter = function (n) {
  var result = [1, 1];
  if (n < 3) {
    return result.slice(-n);
  }
  for (i=3; i<=n; i++) {
    result.push(result[i-3] + result[i-2]);
  }
  return result;
}

var fibs_recursion = function (n){
  var last;
  if (n<3){
    return [1,1].slice(-n);
  }
  else{
    last = fibs_recursion(n-1);
    // console.log(last);
    // console.log(typeof last);
    return last.concat(last[last.length-1] + last[last.length-2]);
  }
}
// TODO
var bsearch = function (arr, target) {
  var midpoint = Math.floor(arr.length / 2)

  if (arr[midpoint] < target) {
    return (midpoint + bsearch(arr.slice(midpoint), target));
  }
  else if (arr[midpoint] > target) {
    return bsearch(arr.slice(0, midpoint), target);
  }
  else if (arr[midpoint] === target) {
    return midpoint;
  }

}

var make_change = function (amount, coins) {
  var best_answer = [];
  var answer;
  if (amount === 0) {
    return [];
  }
  for (var i = 0; i < coins.length; i++) {

    if (amount < coins[i]) continue;

    remainder = amount - coins[i];

    best_remainder = make_change(remainder, coins);

    answer = [coins[i]].concat(best_remainder);

    if (best_answer.length === 0 || best_answer.length > answer.length) {
      best_answer = answer;
    }

  }
  return best_answer;
}

var merge_sort = function(arr) {
  if (arr.length < 2) return arr;

  var midpoint = Math.floor(arr.length/2);
  var left = arr.slice(0, midpoint);
  var right = arr.slice(midpoint);
  return merge(merge_sort(left), merge_sort(right));
}

var merge = function(arr1, arr2) {
  var result = [];
  while (arr1.length > 0 && arr2.length > 0){
    if (arr1[0] < arr2[0]){
      result.push(arr1.shift());
    }
    else{
      result.push(arr2.shift());
    }
  }
    return result.concat(arr1).concat(arr2);
}

var subsets = function (arr) {
  if (arr.length === 0) return [arr];

  var remaining_subsets = subsets(arr.slice(1));
  var complete_subsets = remaining_subsets.map(function(el) {
    return el.concat(arr[0]);
  });

  return remaining_subsets.concat(complete_subsets);
}

console.log(subsets([1,2,3]))
