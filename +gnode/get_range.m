function l = get_range(session, object_type, start, stop)

  n = stop - start + 1;
  ids = cell(1,n);
  
  for i=1:n
    ids{i} = [object_type '_' num2str((start -1) + i)];
  end

  l = gnode.get(session, ids.');

end
