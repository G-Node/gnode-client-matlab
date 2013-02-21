function u = update(session, obj, id)
%UPDATE Deploys changes to G-Node data store objects to the remote
%container defined by the session. The object's corresponding neo_id
%needs to be specified in some way: either explicitly, or via an
%implicit 'neo_id' field on the object. Object is validated before
%upload. Function returns ID of successfully stored object.
%
%  id = update(g, the_object) applies changes to remote.
%
%  id = update(g, the_object, 'analogsignal_947') applies changes
%  for explicitly named object.

import gnode.*;
  
% Update only possible with explicitly specified ID, either per
% argument or as 'neo_id' field on input structure.
  
if (nargin < 3)
    if (isfield(obj, 'id'))
        id = obj.id;
    else
        error('[GNODE] Cannot perform update without id. Please specify');
    end
end

% Validate object

obj = strip(session, obj);

if (~validate(session, obj))
    error('[GNODE] Object did not pass validation. Please adjust');
end

obj = rmfield(obj, 'id');

% Prelim: Fix IDs

import org.gnode.lib.matlab.*;

try
    object_type = Helper.guessType(id);
catch
    error('[GNODE] Could not guess type. Needs specification');
end

parents = cell(session.connector.validator.getParents(object_type));
%children = cell(session.connector.validator.getChildren(object_type));

relations = parents;

for idx = 1:length(relations)
    name = relations{idx};
    if isfield(obj, name)
        rel_name = getfield(obj, name);
        rel_name = rel_name{1};
        obj = setfield(obj, name, gnode.id(rel_name));
    end
end

% Serialize from MATLAB struct to NEObject

import gnode.*;
try
    neo_object = deserialize(session, obj);
catch
    error('[GNODE] Problem while serializing object. Please check validity first');
end

% Now update object accordingly

ret = session.connector.update(id, neo_object);
u = cell(ret);

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