function u = update(session, obj, id)

  % Update only possible with explicitly specified ID, either per
  % argument or as 'neo_id' field on input structure.
	 
  if (nargin < 3)
    if (isfield(obj, 'neo_id'))
      id = obj.neo_id;
    else
      error('[GNODE] Cannot perform update without neo_id. Please specify');
    end
  end

  % Serialize from MATLAB struct to NEObject
  
  import gnode.*;
  try
    neo_object = deserialize(obj);
  catch
    error('[GNODE] Problem while serializing object. Please check validity first');
  end

  % Now update object accordingly

  ret = session.connector.update(id, neo_object);
  u = cell(ret);
  
end
