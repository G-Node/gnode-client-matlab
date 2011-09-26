function result = find_simple(objects, field, search_term)

  % Combs through objects and returns all objects containing
  % the search terms.

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
	if (~isempty(strfind(getfield(objects{i}, field{k}), search_term)))
	  matches{end+1} = objects{i};
	end
      end
    end
  end

  result = matches;

end
