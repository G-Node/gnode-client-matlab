function u = get_updated(session, obj, id)

  import gnode.*;
	 
  % Update object and return updated copy!

  if (nargin < 3)
    updated_id = update(session, obj){1};
  else
    updated_id = update(session, obj, id){1};
  end

  u = get(session, updated_id);

end
