function st = serialize(obj)
  %SERIALIZE Internal function that builds a structure from a given
  %Scala NEObject.
  %
  %  structure = serialize(scala_neobject) returns a fully
  %  transformed NEObject.

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