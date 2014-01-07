function l = search(session, object_type, varargin)
%SEARCH Retrieves  a list of all objects of specified object type that
%match the criteria. By specifying search criteria as key-value pairs, you
%can filter the list of objects this function generates.
%
%  list = search(g, 'analogsignal', 1, 'name', 'cell') returns
%  a list of all available signals whose name contains the word 'cell'.
%  This match is case-insensitive; further search criteria may be used.

%% Defaults

if nargin < 4
    error('[GNODE] Please specify criteria');
end

limit = 500;
offset = 0;

%% Argument classification

if mod(length(varargin), 2) ~= 0
    error('[GNODE] Please specify key-value pairs');
end

criteria = {};
for idx = 1:2:length(varargin)
    criteria{end+1} = [varargin{idx} '|' varargin{idx+1}];
end

%% Search

try
    l = cell(session.connector.retrieveList(object_type, limit, offset, criteria));
catch
    error('[GNODE] Could not retrieve list!');
end

l = cellfun(@(x) char(x), l, 'UniformOutput', 0);

end