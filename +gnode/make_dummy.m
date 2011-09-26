function dummy = make_dummy(session, object_type, minimal)

  import gnode.*;

  % Returns a "readymade" structure for creating new objects
  % with all available (valid) fields added but left blank.

  if (nargin < 3)
    minimal = false;
  elseif (nargin < 2)
    error('[GNODE] Too few arguments');
  end

  try
    data_fields = cell(session.connector.validator.getData(object_type));
    attr_fields = cell(session.connector.validator.getAttributes(object_type));
    child_fields = cell(session.connector.validator.getChildren(object_type));
    parent_fields = cell(session.connector.validator.getParents(object_type));
  catch
    error('[GNODE] Requested type not found in API spec');
  end

  prep_dummy = struct();

  for i = 1:size(data_fields, 1)
    prep_dummy = setfield(prep_dummy, data_fields{i}, struct('units', '', 'data', 0));
  end

  for i = 1:size(attr_fields, 1)
    prep_dummy = setfield(prep_dummy, attr_fields{i}, '');
  end

  for i = 1:size(child_fields, 1)
    prep_dummy = setfield(prep_dummy, child_fields{i}, {});
  end

  for i = 1:size(parent_fields, 1)
    prep_dummy = setfield(prep_dummy, parent_fields{i}, {});
  end

  dummy = prep_dummy;

end
