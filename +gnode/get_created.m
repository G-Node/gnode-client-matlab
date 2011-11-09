function c = get_created(session, obj, object_type)
  %GET_CREATED Creates and retrieves a G-Node data store object in
  %one procedure call. This is a thin wrapper on top of create()/
  %get(), so the respective documentation applies. Object type is
  %optional, but not guaranteed to be guessed correctly.
  %
  %  new_object = get_created(g, obj, 'analogsignal') creates and
  %  returns signal 'obj' on remote.

  import gnode.*;

  % Create and return a new object

  if (nargin < 3)
    new_id = create(session, obj){1};
  else
    new_id = create(session, obj, object_type){1};
  end

  c = get(session, new_id);

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