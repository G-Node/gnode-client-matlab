function reloaded = sync(session, obj, discard)
  %SYNC Synchronizes an object with remote. Useful in situations
  %when update() etc. have changed local object(s). If 'discard'
  %is set, changes are thrown out.
  %
  %  obj = sync(g, obj, false) updates 'obj' on remote and fetches
  %  updated object, storing it in 'obj'.

  import gnode.*;

  if (nargin < 3)
    discard = false;
  end

  if (~isfield(obj, 'neo_id'))
    error('[GNODE] No neo_id. Could not identify object. Please specify');
  else
    if (~discard)
      update(session, obj);
    end
    reloaded = get(session, obj.neo_id);
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