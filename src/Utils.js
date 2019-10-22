exports.annotateFn = function(name) {
  return function(fn) {
    return function(x) {
      var span = Profile.begin(name);
      var value = fn(x);
      Profile.end(span);
      return value;
    };
  };
};
