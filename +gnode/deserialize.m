function neo_obj = deserialize(s)
  %DESERIALIZE Internal function that builds NEObject from appropriate
  %structure. Does not perform validation; only safe for pre-
  %validated MATLAB structs.
  %
  %  neo_object = deserialize(str) returns a Java object corresponding
  %  to contents of passed structure.

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
	% Make Java array
	arr = javaArray('java.lang.String', size(value, 1));
	for i = 1:size(value,1)
	    arr(i) = java.lang.String(value(i));
	end
	b.add(name, arr);
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