function detached = get_detached(session, request, named)
  %GET_DETACHED Convenience function that returns raw signal data
  %only. Works with analogsignal, irssanalogsignal, spiketrain.
  %Final parameter, 'named', determines whether the data arrays
  %are to be returned as either
  %
  %a) a structure with field names corresponding to object names, or
  %b) a cell array containing the data.
  %
  %  raw = get_detached(g, 'analogsignal_947') returns only signal
  %  data associated with remote object without meta-information.
  %
  %  raw = get_detached(g, obj_names, true) returns a struct whose
  %  fields correspond to signal data of specified remote objects.
  %  Field names are equivalent to object names.

  import gnode.*;

  if (nargin < 2)
    error('[GNODE] Insufficient arguments');
  end

  if (nargin < 3)
    named = false;
  end

  data = get(session, request);

  if(isempty(data))
    detached = {};
    return;
  end

  if (size(data, 2) == 1)
    data = { data };
  end

  if (named)
    ret = struct();
    for i = 1:size(data,2)
      obj = data{i};
      if (isfield(obj, 'signal'))
	ret = setfield(ret, obj.neo_id, obj.signal.data);
      end
    end
  else
    ret = {};
    for i = 1:size(data,2)
      obj = data{i};
      if (isfield(obj, 'signal'))
	ret{end + 1} = obj.signal.data;
      end
    end
  end

  detached = ret;
  
  if ((size(ret, 2) == 1) && iscell(ret))
    detached = ret{1};
  end

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