function id = create(session, obj, object_type)

  import gnode.*;
	 
  % Check if object type is specified. If not, fall back on
  % 'obj_type' field. If that can't be found, raise error.

  if (nargin < 3)
    if (isfield(obj, 'obj_type'))
      object_type = obj.obj_type;
    else
      error('[GNODE] Cannot perform create without object type. Please specify');
    end
  end

  % Validate

  if (~validate(session, obj, object_type))
    error('[GNODE] Object did not pass validation. Please adjust');
  end

  % Serialize from MATLAB struct to NEObject

  import gnode.*;
  try
    neo_object = deserialize(obj);
  catch
    error('[GNODE] Problem while serializing object. Please check validity first');
  end

  ret = session.connector.create(neo_object, object_type);
  id = cell(ret);

end
