function obj = get_filtered(session, request, object_type)

  % Convenience function. Wraps get() and filter() in
  % a combined call.
	 
  import gnode.*;

  res = get(session, request);
  collection = {};
  
  for i = 1:size(res, 2)
    collection{end+1} = filter(session, res{i}, object_type);
  end

  obj = collection;

end
