function replace_ids(s, name){
  var new_id = new Date().getTime();
  var to_rep = 'new_'+name+'';
  return s.replace(new RegExp(to_rep, "g"), new_id);
}
