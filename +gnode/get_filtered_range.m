function l = get_filtered_range(session, object_type, start, stop)

  % Combination of get_range/filter
	 
  import gnode.*;

  res = get_range(session, object_type, start, stop);
  collection = {};

  for i = 1:size(res, 2)
    collection{end+1} = filter(session, res{1}, object_type);
  end

  l = collection;

end
