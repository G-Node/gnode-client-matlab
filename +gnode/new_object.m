function d = new_object(varargin)
%NEW_OBJECT Allows the creation of objects in one call. Please provide
%session, type of object, and all object attributes as key-value pairs.
%
%  s = new_object(session, 'segment', 'name', 'A segment');
%  as = new_object(session, 'analogsignal', 'name', 'A signal', ...
%                  't_start', struct('units', 'ms', 'data', 0), ...
%                  'sampling_rate', struct('units', 'Hz', 'data', 1), ...
%                  'signal', struct('units', 'mV', 'data', [1 2 3]);

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