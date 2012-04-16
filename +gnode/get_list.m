function final_list = get_list(session, object_type, limit, offset)
%GET_LIST Retrieves an exhaustive list of all objects of specified
%object type that are available in the specified session. A limit
%may be specified.
%
%  list = get_list(g, 'analogsignal', 100, 0) returns a list of all
%  available signals limited to 100 entries and with an offset of
%  zero (that is, starting at first signal).

if (nargin < 4)
    offset = 0;
end

if (nargin < 3)
    limit = 100;
end

try
    l = cell(session.connector.retrieveList(object_type, limit, offset));
catch
    error('[GNODE] Could not retrieve list!');
end

final_list = cellfun(@(x) char(x), l, 'UniformOutput', 0);

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