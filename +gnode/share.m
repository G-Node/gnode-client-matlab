function share(session, objects, user, level, cascade)

%% Defaults

if nargin < 5
    cascade = 1;
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
        objects = cellfun(@(x) x.id, objects);
    catch
        error(err_msg);
    end
end

% No interpretation available
if ~iscellstr(objects)
    error(err_msg);
end

%% Share

for obj = objects
    if ~session.connector.shareObject(obj, user, level, cascade);
        error('[GNODE] Could not share object %s', obj);
    end
end

end