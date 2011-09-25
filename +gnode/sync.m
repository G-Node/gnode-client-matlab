function reloaded = sync(session, obj, discard)

  import gnode.*;

  % Synchronizes an object with remote. Useful in situations
  % when update() etc. have changed local object(s). If 'discard'
  % is set, changes are thrown out!

  if (nargin < 3)
    discard = false;
  end

  if (~isfield(obj, 'neo_id'))
    error('[GNODE] No neo_id. Could not identify object. Please specify');
  else
    if (~discard)
      update(session, obj);
    end
    reloaded = get(session, obj.neo_id);
  end

end
