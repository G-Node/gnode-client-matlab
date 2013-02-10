function my_objects = get(session, request, download_flag)
%GET Retrieves a single or multiple G-Node data store objects from
%the remote container. If possible (i.e., for objects not recently
%modified), a cached representation is returned. For several
%objects, use cell arrays of IDs. Return order is not guaranteed.
%
%  remote_object = get(g, 'analogsignal_947') returns a structure
%  corresponding to form and content of the indicated data object.
%
%  remote_objects = get(g, {'analogsignal_47', 'block_5'}) returns
%  an array of objects corresponding to form and content of the
%  indicated data objects.

% Pull auxiliary functions into scope

import gnode.*;

% Sanity check
if nargin < 3
   download_flag = 1;
end

if nargin < 2
    error('[GNODE] Insufficient parameters');
end

% Container for return objects
my_objects = {};

try
   
  if (~iscellstr(request)) % Single request

    obj = session.connector.retrieve(request);

    if (~is_none(obj)) % Scala-specific check of Some-typed result
      my_objects = serialize(obj.get);
    else
      error('[GNODE] Could not retrieve object %s', request);
    end

  else % Multiple requests

    for k = 1:length(request)
      obj = session.connector.retrieve(request{k});
      if (~is_none(obj))
        my_objects{end+1} = serialize(obj.get);
      else
        fprintf(sprintf('[GNODE] Warning: Object %s could not be retrieved\n', ...
			request{k}));
      end
    end

  end

catch
     
  error('[GNODE] Error while retrieving objects');

end

if download_flag

   % Let's grab connector:
   t = session.connector;
   
   % Hacky: One code path for single/multiple entities
   if length(my_objects) == 1, my_objects = {my_objects}; end
   
   for k = 1:length(my_objects)
       
       o = my_objects{k};
       if isfield(o, 'signal')
	  if isfield(o.signal, 'url')
	     % This means, we should get the data:
	     try
		temp_data = char(t.downloadData(o.signal.url));
		o.signal.data = h5read(temp_data, '/data');
		my_objects{k} = o;
	     catch
		  error('[GNODE] Could not download the associated data. Check network connection.');
	     end
	  end
       end

   end

   if length(my_objects) == 1, my_objects = my_objects{1}; end

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
