function id = create(session, obj, object_type)
  %CREATE Creates new object of specified object type on remote G-Node
  %data store. Attempts to guess object type where possible; explicit
  %argument is, however, preferred. New object needs to pass both
  %client- and server-side validation. Returns generated ID for new
  %object upon success.
  %
  %  new_id = create(g, new_obj, 'analogsignal') returns ID of newly
  %  stored signal, and throws an exception in case of transmission
  %  problems.

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