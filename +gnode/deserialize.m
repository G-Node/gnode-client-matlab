function neo_obj = deserialize(s)

  import org.gnode.lib.neo.*;
  b = NEOBuilder;

  names = fieldnames(s);
  for i = 1:size(names, 1)

    name = names(i);
    value = getfield(s, char(name));
    
    if (~isstruct(value))
      if (~iscell(value))
	b.add(name, value);
      elseif (size(value, 1) > 1)
	b.add(name, value);
      elseif (size(value, 1) == 1)
	b.add(name, value{1});
      end
    else
      if (size(value.data, 1) < 2)
	b.add(name, NEODataSingle(value.units, value.data(1)));
      else
	b.add(name, NEODataMulti(value.units, value.data));
      end
    end
    
  end

  neo_obj = b.build;

end
