function objects = from_prototype(session, prototype, field, content, make_signal, units)

  % Creates multiple objects from content by filling in a
  % specified field of the supplied prototype.

  if (nargin < 6)
    make_signal = false;
  elseif (nargin < 4)
    error('[GNODE] Missing arguments. Please try again');
  end

  if (~isfield(prototype, field))
    error('[GNODE] Could not find field on supplied object');
  end

  if (~iscell(content))
    content = { content };
  end

  objects = {};
  content = content.';
  
  for i = 1:size(content, 1)
    if (make_signal)
      attach = struct('units', units, 'data', content{i});
    else
      attach = content{i};
    end
    copy = setfield(prototype, field, attach);
    objects{end + 1} = copy;
  end

end
