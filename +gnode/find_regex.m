function result = find_regex(objects, field, re)

  % Combs through objects and returns all objects matching the regular
  % expression in question. Uses case-insensitive regexes.

  if (nargin < 3)
    error('[GNODE] Too few arguments. Please specify objects, field names and regular expression');
  end

  if (~iscell(field))
    field = { field };
  end

  matches = {};

  for i = 1:size(objects, 2)
    for k = 1:size(field, 1)
      if (isfield(objects{i}, field{k}))
	if (~isempty(regexpi(getfield(objects{i}, field{k}), re)))
	  matches{end+1} = objects{i};
	end
      end
    end
  end

  result = matches;

end
