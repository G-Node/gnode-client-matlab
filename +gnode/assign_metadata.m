function ret = assign_metadata(targets, values)

%% Generate list of values
if isstruct(values) && isfield(values, 'id')
    % Single value
    parts = regexp(values.id, '_', 'split');
    metadata = {parts{2}};
elseif iscell(values)
     for j = 1:length(values)
         parts = regexp(values{j}.id, '_', 'split');
         metadata{j} = parts{2};
     end
else
    error('[GNODE] Invalid input!');
end

if isstruct(targets)
    ret = setfield(targets, 'metadata', metadata);
else
    for k = 1:length(targets)
        ret{k} = setfield(targets{k}, 'metadata', metadata);
    end
end

end