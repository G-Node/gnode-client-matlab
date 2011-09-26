function l = get_list(session, object_type, limit)

  if (nargin < 3)
    limit = 0;
  end

  try
    l = cell(session.connector.retrieveList(object_type, limit));
  catch
    error('[GNODE] Could not retrieve list!');
  end

end
