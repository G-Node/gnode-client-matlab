function new = strip(session, obj, object_type)
  %STRIP Returns a clean version of a given NEObject based on
  %contracts specified by present session validator. Only fundamental
  %object information as specified in the G-Node data storage format
  %remains. Incidental information such as creation date, ownership
  %etc. are discarded. Out of non-essential object properties, only
  %neo_id is preserved for reasons of convenience.
  %
  %  stripped_object = strip(g, signal, 'analogsignal') returns a
  %  clean version of the specified object. Object type is explicitly
  %  stated.
  %
  %  stripped_object = strip(g, signal) returns a clean version whose
  %  type is guessed based on heuristics. NB, this type guess can fail
  %  in which case object type needs to be made unambiguous.

  if (nargin < 3)

    % Attempt to determine type without explicit information 
    import org.gnode.lib.matlab.Helper;

    try
      id = obj.id;
      object_type = Helper.guessType(id);
    catch
      error('[GNODE] Object type necessary. Please specify');
    end
    
  end

  legal_fields = cell(session.connector.validator.getAll(object_type));
  legal_fields{end+1} = 'neo_id'; % Additionally, we keep neo_id
  
  fields = fieldnames(obj);
  new_object = struct();

  for i = 1:size(fields, 1)
    if (any(ismember(legal_fields, fields{i})))
      new_object = setfield(new_object, fields{i}, getfield(obj, fields{i}));
    end
  end

  new = new_object;

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