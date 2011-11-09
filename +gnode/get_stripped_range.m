function l = get_stripped_range(session, object_type, start, stop)
  %GET_STRIPPED_RANGE Combination of get_range()/strip(). Identical
  %syntax and semantics apply.
  %
  %  clean_objects = get_stripped_range(g, 'analogsignal', 100, 104)
  %  returns all objects between 'analogsignal_100' and
  %  'analogsignal_104' without extraneous information.
	 
  import gnode.*;

  res = get_range(session, object_type, start, stop);
  collection = {};

  for i = 1:size(res, 2)
    collection{end+1} = strip(session, res{1}, object_type);
  end

  l = collection;

end
