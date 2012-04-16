function list_metadata(session, objects)

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

%% Display

for oidx = 1:length(objects)

    obj = gnode.get(session, objects{oidx});
    vals = gnode.get(session, obj.metadata);
    
    if ~isempty(vals)
        
        fprintf('\nObject ID: %s\n', objects{oidx});
        fprintf('===========================\n\n');

        for j = 1:length(vals)

            prop = gnode.get(session, ['properties_' num2str(vals{j}.parent_property)]);
            fprintf('%s:\t%s\n', prop.name, vals{j}.data);

        end
        
    else
        
        fprintf('[GNODE] No metadata available. Start tagging!\n');
        
    end
    
end

end