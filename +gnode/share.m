function share(session, objects, safety_level, users, levels, cascade)
%SHARE Modify an entity's permissions. The required parameters are session,
%either a single object (or its ID) or a list of objects (or their IDs),
%safety level (1 = public, 2 = group, 3 = private), the user(s) in question
%(as a cell array), user access levels (as an array), and whether the
%modification should apply to all nested objects (cascade).
%
%  gnode.share(session, 'analogsignal_1', 1, {'john'}, [2], 0) makes
%  'analogsignal_1' publicly available and writable for user john. In this
%  case, changes do not cascade to nested objects.

%% Defaults

if nargin < 6
    cascade = 0;
end

if nargin < 5
    levels = [0];
end

if nargin < 4
    users = {''};
end

if nargin < 3
    error('[GNODE] Please specify safety level!');
end

%% Argument classification

err_msg = '[GNODE] Please specify objects to be shared';

% Single ID
if ischar(objects)
    objects = {objects};
end

% Single object
if isstruct(objects)
    if isfield(objects, 'id')
        objects = {objects.id};
    else
        error(err_msg);
    end
end

% Cell array of objects
if iscell(objects) && ~iscellstr(objects)
    try
        objects = cellfun(@(x) x.id, objects, ...
            'UniformOutput', 0);
    catch
        error(err_msg);
    end
end

% No interpretation available
if ~iscellstr(objects)
    error(err_msg);
end

% Convert cell array to Java string array
j_users = javaArray('java.lang.String', length(users));
for idx = 1:length(users), j_users(idx) = java.lang.String(users{idx}); end

%% Share

for o = 1:length(objects)
    if ~session.connector.shareObject(objects{o}, safety_level, users, ...
            levels, cascade);
        error('[GNODE] Could not share object %s', obj);
    end
end

end