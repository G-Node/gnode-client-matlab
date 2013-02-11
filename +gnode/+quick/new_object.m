function d = new_object(varargin)

import gnode.*;

session = varargin{1};
object_type = varargin{2};

try
  d = make_dummy(session, object_type);
catch
  error('[GNODE] Failed to generate object dummy. Check object type validity.');
end

if mod(length(varargin), 2) ~= 0
  error('[GNODE] Number of supplied key-value pairs needs to be multiple of 2.');
end

for k = 3:2:length(varargin)
  d = setfield(d, varargin{k}, varargin{k+1});
end

end