function st = serialize(obj)

  str_keys = obj.getStringKeys;
  num_keys = obj.getNumKeys;
  data_keys = obj.getDataKeys;
  rel_keys = obj.getRelKeys;

  struct_builder = struct();

  for k = 1:size(str_keys,1)
      struct_builder = setfield(struct_builder, char(str_keys(k)), char(obj.stringInfo.get(str_keys(k)).get));
  end

  for k = 1:size(num_keys,1)
      struct_builder = setfield(struct_builder,	char(num_keys(k)), obj.numInfo.get(num_keys(k)).get);
  end

  for k = 1:size(rel_keys,1)
      struct_builder = setfield(struct_builder,	char(rel_keys(k)), cell(obj.relations.get(rel_keys(k)).get));
  end

  for k = 1:size(data_keys,1)

    data_object = obj.data.get(data_keys(k)).get;
    data_struct = struct('units', char(data_object.getUnits), 'data', data_object.getData);
    
    struct_builder = setfield(struct_builder, char(data_keys(k)), data_struct);
    
  end

  st = struct_builder;
  
end
