function changed = assign(target, obj)

if isstruct(obj) && isfield(obj, 'id')
    obj_id = obj.id;
end

if ischar(obj)
    obj_id = obj;
end

parts = regexp(obj_id, '_', 'split');

if strcmp(parts{1}, 'sections'); parts{1} = 'section'; end
if strcmp(parts{1}, 'properties'); parts{1} = 'parent_property'; end
if strcmp(parts{1}, 'values'); error('[GNODE] Use gnode.assign_metadata instead!'); end

if isstruct(target)
    target = {target};
end

if iscell(target)
    changed = cellfun(@(t) setfield(t, parts{1}, str2num(parts{2})), ...
        target, 'UniformOutput', 0);
else
    error('[GNODE] Invalid input!');
end

if length(changed) < 2
    changed = changed{1};
end

end