function neo_obj = deserialize(session, s)
%DESERIALIZE Internal function that builds NEObject from appropriate
%structure. Does not perform validation; only safe for pre-
%validated MATLAB structs.
%
%  neo_object = deserialize(str) returns a Java object corresponding
%  to contents of passed structure.

import org.gnode.lib.neo.*;

b = NEOBuilder;
names = fieldnames(s);

for j = 1:size(names, 1)

    name = char(names(j));
    value = getfield(s, name);
    
    if isempty(value)
        continue
    end
    
    if numel(strfind(char(name), '_set')) > 0
        continue
    end

    if (~isstruct(value))
        if (~iscell(value))
            b.add(name, value);
        elseif (length(value) > 1) || strcmp(name, 'metadata')
            % Make Java array
            arr = javaArray('java.lang.String', size(value, 1));
            for k = 1:length(value)
                arr(k) = java.lang.String(value(k));
            end
            b.add(name, arr);
        elseif (size(value, 1) == 1)
            b.add(name, value{1});
        end
    else
        if (length(value.data) < 2) && ~strcmp(name, 'times') && ~strcmp(name, 'signal')
            if ~isempty(value.units)
                b.add(name, NEODataSingle(value.units, value.data(1)));
            end
        else
            % Create appropriate temporary HDF5 file
            temporary_file = [tempname '.h5'];
            hdf5write(temporary_file, '/data', value.data);
            % Upload HDF5 file
            try
                h5_permalink = session.connector.uploadData(temporary_file);
            catch
                error('[GNODE] Could not store data on server.');
            end
            % Create containing entity
            b.add(name, NEODataMulti(value.units, h5_permalink));
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