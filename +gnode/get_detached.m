function detached = get_detached(session, request, named)

  import gnode.*;

  % Convenience function that returns raw signal data only. Works
  % with analogsignal, irssanalogsignal, spiketrain.

  if (nargin < 3)
    named = false;
  end

  data = get(session, request);

  if(isempty(data))
    detached = {};
    return;
  end

  if (size(data, 2) == 1)
    data = { data };
  end

  if (named)
    ret = struct();
    for i = 1:size(data,2)
      obj = data{i};
      if (isfield(obj, 'signal'))
	ret = setfield(ret, obj.neo_id, obj.signal.data);
      end
    end
  else
    ret = {};
    for i = 1:size(data,2)
      obj = data{i};
      if (isfield(obj, 'signal'))
	ret{end + 1} = obj.signal.data;
      end
    end
  end

  detached = ret;
  
  if ((size(ret, 2) == 1) && iscell(ret))
    detached = ret{1};
  end

end
