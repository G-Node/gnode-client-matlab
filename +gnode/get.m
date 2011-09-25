function s = get(session, request)

  import gnode.*;

  my_objects = {};
  
  if (~iscellstr(request))
     
    obj = session.connector.retrieve(request);
    if (~is_none(obj))
      my_objects = serialize(obj.get);
    end

  else

    for k = 1:size(request,1)
      obj = session.connector.retrieve(request{k});
      if (~is_none(obj))
	my_objects{k} = serialize(obj.get);
      end
    end

  end

  s = my_objects;

end
