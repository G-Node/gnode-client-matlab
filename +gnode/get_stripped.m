function obj = get_stripped(session, request, object_type)
  %GET_STRIPPED Convenience function. Wraps get() and strip() in
  %a combined call, returning remote G-Node data store objects
  %sans transmission/ownership information. Documentation for
  %both applies.
  %
  %  clean_objects = get_stripped(g, 'analogsignal_947', 'analogsignal')
  %  returns 'analogsignal_947' without extraneous information.
	 
  import gnode.*;

  res = get(session, request);
  collection = {};

  if (~iscell(res))

    obj = strip(session, res, object_type);

  else
      
    for i = 1:size(res, 2)
      collection{end+1} = strip(session, res{i}, object_type);
    end

    obj = collection;

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