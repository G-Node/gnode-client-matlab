function cascade_entity = get_cascade(session, id)

  import gnode.*;
	 
  % Retrieve children of object recursively, and store
  % under respective category.

  top_level = get(session, id);

  try
    import org.gnode.lib.matlab.*;
    object_type = Helper.guessType(top_level.neo_id);
  catch
    error(sprintf('[GNODE] Could not guess type for object %s', id));
  end

  possible_children = cell(session.connector.validator.getChildren(object_type));

  % Iterate through all *possible* children for this particular
  % object, and determine whether the object has any children of
  % this type. If so, retrieve each one of them recursively using
  % get_cascade().
  
  for i = 1:size(possible_children, 1)

    if(isfield(top_level, possible_children{i}))

      category = possible_children{i};
      list = getfield(top_level, category);

      collector = {};
      
      for k = 1:size(list, 1)
	collector{end + 1} = get_cascade(session, list{k});
      end

      top_level = setfield(top_level, category, collector);

    end

  end

  cascade_entity = top_level;	   

end
