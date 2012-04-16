function list_metadata(session, id)

obj = gnode.get(session, id);
vals = gnode.get(session, obj.metadata);

for j = 1:length(vals)
    
    prop = gnode.get(session, ['properties_' num2str(vals{j}.parent_property)]);
    fprintf('%s:\t%s\n', prop.name, vals{j}.data);
    
end

end