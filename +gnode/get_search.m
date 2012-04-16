function l = get_search(session, object_type, criteria, limit, offset)

%% Defaults

if nargin < 5
    offset = 0;
end

if nargin < 4
    limit = 1000;
end

if nargin < 3
    error('[GNODE] Please specify criteria');
end

%% Argument classification

err_msg = '[GNODE] Please specify appropriate criteria!';

% Single ID
if ischar(criteria)
    criteria = {criteria};
end

% Single object
if isstruct(criteria)
    if isfield(criteria, 'id')
        criteria = {criteria.id};
    else
        error(err_msg);
    end
end

% Cell array of objects
if iscell(criteria) && ~iscellstr(criteria)
    try
        criteria = cellfun(@(x) x.id, criteria, ...
            'UniformOutput', 0);
    catch
        error(err_msg);
    end
end

% No interpretation available
if ~iscellstr(criteria)
    error(err_msg);
end

%% Fix metadata issue

for j = 1:length(criteria)
    parts = regexp(criteria{j}, '_', 'split');
    if strcmp(parts{1}, 'values'); criteria{j} = ['metadata_' parts{2}]; end
end

%% Search

try
    l = cell(session.connector.retrieveList(object_type, limit, offset, criteria));
catch
    error('[GNODE] Could not retrieve list!');
end

l = cellfun(@(x) char(x), l, 'UniformOutput', 0);

end