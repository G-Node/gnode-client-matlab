function obj = get_filtered(session, request, object_type)

  % Convenience function. Wraps get() and filter() in
  % a combined call.
	 
  import gnode.*;

  res = get(session, request);
  collection = {};

  if (~iscell(res))

    obj = filter(session, res, object_type);

  else
      
    for i = 1:size(res, 2)
      collection{end+1} = filter(session, res{i}, object_type);
    end

    obj = collection;

  end

end
