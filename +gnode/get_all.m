function s = get_all(session)

  import gnode.*;
  my_objects = {};
  objects = session.connector.retrieve;

  for i = 1:size(objects,1)
      my_objects{i} = serialize(objects(i));
  end

  s = my_objects;

end
