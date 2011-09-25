function modified = connect(session, obj1, obj2, remote)

  import gnode.*;
  import org.gnode.lib.matlab.Helper;
  
  % Connects two NEObjects by setting their respective relation
  % fields to each other's NEO ID. This requires knowledge of
  % a) their IDs and by extension b) their types. If this
  % information is not given, the procedure fails. Type hints
  % in form of artificially added neo_id's circumvent this
  % problem.

  if (nargin < 4)
    remote = false;
  end

  % Derive types from IDs or error out

  if (~isfield(obj1, 'neo_id') || ~isfield(obj2, 'neo_id'))
    error('[GNODE] neo_id is required. Please add if known and retry');
  end

  try
    type1 = Helper.guessType(obj1.neo_id);
    type2 = Helper.guessType(obj2.neo_id);
  catch
    error('[GNODE] Could not derive object type. Please provide well-formed neo_id');
  end

  % Determine if connectable

  parents1 = cell(session.connector.validator.getParents(type1));
  parents2 = cell(session.connector.validator.getParents(type2));

  children1 = cell(session.connector.validator.getChildren(type1));
  children2 = cell(session.connector.validator.getParents(type2));

  %fprintf('ismember(parents2, type1) is %d\nismember(children1, type2) is %d\nismember(parents1, type2) is %d\nismember(children2, type1) is %d\n', ismember(parents2, type1), ismember(children1, type2), ismember(parents1, type2), ismember(children2, type1));

  type1 = char(type1);
  type2 = char(type2);
  
  if (~((any(ismember(parents2, type1)) && any(ismember(children1, type2))) || (any(ismember(parents1, type2)) && any(ismember(children2, type1)))))
    error('[GNODE] Objects cannot be connected!');
  end

  % Do the connect

  new_field1 = getfield(obj1, type2);
  new_field1{end + 1} = obj2.neo_id;
  
  new_obj1 = setfield(obj1, type2, new_field1);

  new_field2 = getfield(obj2, type1);
  new_field2{end + 1} = obj1.neo_id;

  new_obj2 = setfield(obj2, type1, new_field2);

  % If requested, save this change to remote

  if (remote)
    update(session, new_obj1);
    update(session, new_obj2);
  end

  % Return new objects
  modified = { new_obj1; new_obj2 };

end
