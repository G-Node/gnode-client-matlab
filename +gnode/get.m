function s = get(session, request)

  import gnode.*;
  
  if (~iscellstr(request))
    my_objects = serialize(session.connector.retrieve(request).get);
  else
    my_objects = {};
    for k = 1:size(request,2)
      my_objects{k} = serialize(session.connector.retrieve(request{k}).get);
    end
  end

  s = my_objects;

end
