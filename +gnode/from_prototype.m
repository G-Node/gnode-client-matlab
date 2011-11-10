function objects = from_prototype(session, prototype, field, \
				  content, make_signal, units)
  %FROM_PROTOTYPE Creates a series of objects from a content array and
  %a prototype (generally created via make_dummy). That is, for each
  %cell in the specified content array, this function creates a copy
  %of the prototype and adds the content cell to the specified field
  %of this copy. If dealing with signal data, a Boolean flag can be
  %specified that coerces the function into creating signal structs
  %with an appropriate specified unit.
  %
  %  new_objects = from_prototype(g, dummy, 'name', name_cell_array)
  %  creates an array of objects whose 'name' fields correspond to the
  %  passed name array.
  %
  %  new_objects = from_prototype(g, dummy, 'signal', raw_data, true, 'mV')
  %  creates an array of signals including properly structured data
  %  fields with unit 'mV'.

  if (nargin < 6)
    make_signal = false;
  elseif (nargin < 4)
    error('[GNODE] Insufficient arguments');
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