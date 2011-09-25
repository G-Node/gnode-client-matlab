function add_get(session, request)

  import gnode.*;

  if (~iscellstr(request))
     session.connector.addDown(request);
  else
    for k = 1:size(request,2)
      session.connector.addDown(request{k});
    end
  end

end
