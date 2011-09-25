function res = validate(session, obj, object_type, strict)

  % Performs either a *negative* or a *positive* check for
  % an object of the given type. Negative refers to checking
  % if every required field is set. Positive refers to checking
  % if only legal fields are set.

  if (nargin == 3)
    strict = false;
  elseif (nargin == 2)
    strict = false;
    import org.gnode.lib.matlab.*;
    try
      object_type = Helper.guessType(obj.neo_id);
    catch
      error('[GNODE] Could not guess type. Needs specification');
    end
  elseif (nargin < 2)
    error('[GNODE] Cannot peform validation sans object');
  end
  
  if (isfield(obj, 'neo_id'))
    id = obj.neo_id;
  else
    id = 'UNKNOWN OBJECT';
  end
  
  % Negative:

  required = cell(session.connector.validator.getRequired(object_type));

  res = true;
  fields = fieldnames(obj);
  
  for i = 1:size(required, 1)
    if (~any(ismember(fields, required{i})))
      res = false;
      fprintf('[GNODE] %s: Required field absent (%s)\n', id, required{i});
    end
  end

  if (res)
    fprintf('[GNODE] %s: All required fields present\n', id);
  end

  % Positive:
  
  if (strict)

    all = cell(session.connector.validator.getAll(object_type));
    all{end+1} = 'neo_id';
    x = setxor(fieldnames(obj), all);

    if (isempty(x))
      fprintf('[GNODE] %s: Only and all valid fields present\n', id);
      res = true;
    else
      problem_strings = '';
      for i = 1:size(x, 1)
	problem_strings = [problem_strings char(x(i))];
      end
      fprintf('[GNODE] %s: Invalid or missing fields (%s)\n', id, problem_strings);
      res = false;
    end

  end

end
