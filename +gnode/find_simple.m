function result = find_simple(objects, field, search_term)
  %FIND_SIMPLE Combs through objects and returns all objects
  %containing the search terms in the specified field. This utility
  %operates case-insensitively.
  %
  %  objects = get_range(g, 'analogsignal', 1000, 1236);
  %
  %  matching_objects = find_simple(objects, 'name', '[...]') now
  %  returns all objects matching the specified terms in the name
  %  field.

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

% Copyright (C) 2011 by German Neuroinformatics Node (www.g-node.org)
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.