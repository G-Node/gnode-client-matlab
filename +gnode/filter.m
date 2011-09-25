function new = filter(session, obj, object_type)

  % Returns a clean version of a given NEObject based on
  % contracts specified in session.validator.

  if (nargin < 3)
    import org.gnode.lib.matlab.Helper;
    try
      id = obj.neo_id;
      object_type = Helper.guessType(id);
    catch
      error('[GNODE] Object type necessary. Please specify');
    end
  end

  legal_fields = cell(session.connector.validator.getAll(object_type));
  legal_fields{end+1} = 'neo_id'; % Additionally, we keep neo_id
  
  fields = fieldnames(obj);
  new_object = struct();

  for i = 1:size(fields, 1)
    if (any(ismember(legal_fields, fields{i})))
      new_object = setfield(new_object, fields{i}, getfield(obj, fields{i}));
    end
  end

  new = new_object;

end
