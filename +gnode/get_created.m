function c = get_created(session, obj, object_type)

  import gnode.*;

  % Create and return a new object

  if (nargin < 3)
    new_id = create(session, obj){1};
  else
    new_id = create(session, obj, object_type){1};
  end

  c = get(session, new_id);

end
