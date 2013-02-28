function final_list = browse_search(session, object_type, varargin)
%BROWSE_SEARCH Retrieves and displays a list of all objects of specified
%object type that are available in the specified session. By specifying
%search criteria as key-value pairs, you can filter the list of objects
%this function generates.
%
%  list = browse_search(g, 'analogsignal', 1, 'name', 'cell') returns and displays
%  a list of all available signals whose name contains the word 'cell'.
%  This match is case-insensitive; further search criteria may be used.

offset = 0;
limit = 500;

if nargin < 4
    error('[GNODE] Please specify criteria for search');
end

if mod(length(varargin), 2) ~= 0
    error('[GNODE] Please specify key-value pairs');
end

criteria = {};
for idx = 1:2:length(varargin)
    criteria{end+1} = [varargin{idx} '|' varargin{idx+1}];
end

try
    l = cell(session.connector.retrieveListAll(object_type, limit, offset, criteria))';
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