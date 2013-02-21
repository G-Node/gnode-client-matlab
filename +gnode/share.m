function share(session, objects, user, level, cascade)
%SHARE Modify an entity's permissions. The required parameters are session,
%either a single object (or its ID) or a list of objects (or their IDs),
%the user in question, safety level (1 = public, 2 = group, 3 = private),
%and whether the modification should apply to all nested objects (cascade).
%
%  gnode.share(session, 'analogsignal_1', 'john', '1', 0);

%% Defaults

if nargin < 5
    cascade = 0;
end

if nargin < 4
    level = 1;
end

if nargin < 3
    error('[GNODE] Please specify user');
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

%% Share

for o = 1:length(objects)
    if ~session.connector.shareObject(objects{o}, user, level, cascade);
        error('[GNODE] Could not share object %s', obj);
    end
end

end