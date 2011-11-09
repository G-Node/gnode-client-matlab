function cascade_entity = get_cascade(session, id)
  %GET_CASCADE Retrieves a top-level G-Node data store object and
  %all its nested dependencies. That is, for an arbitrary object
  %block_25, all connected objects (e.g., segments, signals, and so
  %on) are fetched as well and stored inside the returned structure.
  %This function operates recursively.
  %
  %NB, for large data sets, this function can consume substantial
  %resources (esp. bandwidth, time). Selective retrieval may be
  %preferrable.
  %
  %  big_object = get_cascade(session, 'block_25') returns a
  %  structure containing all sub-objects of block_25.

  import gnode.*;
	 
  % Retrieve children of object recursively, and store
  % under respective category.

  top_level = get(session, id);

  try
    import org.gnode.lib.matlab.*;
    object_type = Helper.guessType(top_level.neo_id);
  catch
    error(sprintf('[GNODE] Could not guess type for object %s', id));
  end

  possible_children = cell(session.connector.validator.getChildren(object_type));

  % Iterate through all *possible* children for this particular
  % object, and determine whether the object has any children of
  % this type. If so, retrieve each one of them recursively using
  % get_cascade().
  
  for i = 1:size(possible_children, 1)

    if(isfield(top_level, possible_children{i}))

      category = possible_children{i};
      list = getfield(top_level, category);

      collector = {};
      
      for k = 1:size(list, 1)
	collector{end + 1} = get_cascade(session, list{k});
      end

      top_level = setfield(top_level, category, collector);

    end

  end

  cascade_entity = top_level;	   

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