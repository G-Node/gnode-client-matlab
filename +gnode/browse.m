function final_list = browse(session, object_type, display, limit, offset)
%BROWSE Retrieves and displays a list of all objects of specified
%object type that are available in the specified session. A limit
%may be determined. In addition to IDs, names and descriptions are shown.
%
%  list = browse(g, 'analogsignal', 1) returns and displays a list of all
%  available signals. The final parameter activates showing available
%  objects in the command window. In addition, limit and offset may be
%  supplied (see get_list).

if nargin < 5
    offset = 0;
end

if nargin < 4
    limit = 100;
end

if nargin < 3
    display = 1;
end

if nargin < 2
    error('[GNODE] Please supply session and object type!');
end

try
    l = cell(session.connector.retrieveListAll(object_type, limit, offset))';
catch
    error('[GNODE] Could not retrieve list!');
end

s = size(l);
final_list = reshape(cellfun(@(x) char(x), l(:), 'UniformOutput', 0), s);

if display
    fprintf('Available objects for %s:\n\n', object_type);
    
    for idx = 1:size(final_list, 1)
        obj = final_list(idx,:);
        fprintf('Object ID: %s\n\tName: %s\n\tDescription: %s\n\n', ...
            char(obj(1)), char(obj(2)), char(obj(3)));
    end
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