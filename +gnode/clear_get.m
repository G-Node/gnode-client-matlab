function clear_get(session)

  % Empties the job queue (download) for this session.
  session.connector.clearDown();

end
