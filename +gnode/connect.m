function [one two] = connect(session, obj1, obj2, remote)
  %CONNECT Connects two NEObjects by setting their respective relation
  %fields to each other's NEO ID. This requires knowledge of a) their
  %IDs and by extension b) their types. If this information is not
  %given, the procedure throws an error.
  %
  %Modification is never in place; new objects are returned. If 'true'
  %is passed as the final argument, connect() performs the intended
  %change remotely. This helper checks if the given objects *can* be
  %connected according to G-Node data object semantics of current
  %session.
  %
  %  [obj1 obj2] = connect(g, block, segment) connects a block and a
  %  segment without deploying the change on the server.
  %
  %  [obj1 obj2] = connect(g, block, segment, true) performs the same
  %  change as above, and immediately adds the connection remotely.
	 
  import gnode.*;
  import org.gnode.lib.matlab.Helper;

  if (nargin < 4)
    remote = false;
  end

  if (nargin < 3)
    error('[GNODE] Insufficient number of arguments');
  end

  % Derive types from IDs or error out

  if (~isfield(obj1, 'neo_id') || ~isfield(obj2, 'neo_id'))
    error('[GNODE] neo_id is required. Please add if known and retry');
  end

  try
    type1 = Helper.guessType(obj1.neo_id);
    type2 = Helper.guessType(obj2.neo_id);
  catch
    error('[GNODE] Could not derive object type. Please provide a well-formed neo_id for both arguments');
  end

  % Determine if connectable

  parents1 = cell(session.connector.validator.getParents(type1));
  parents2 = cell(session.connector.validator.getParents(type2));

  children1 = cell(session.connector.validator.getChildren(type1));
  children2 = cell(session.connector.validator.getChildren(type2));

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
  one = new_obj1;
  two = new_obj2;

end

% Copyright (C) 2011 by German Neuroinformatics Node (www.g-node.org)
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.
