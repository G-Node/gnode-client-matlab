function dummy = make_dummy(session, object_type, minimal)
%MAKE_DUMMY Returns a "readymade" structure for creating new
%objects with all available (valid) fields added but left blank.
%Key purpose is rapid creation of G-Node data store objects by
%MATLAB users.
%
%  dummy = make_dummy(g, 'analogsignal') returns a structure
%  containing empty fields for all signal-related properties
%  that are required by the G-Node validator.

import gnode.*;

if (nargin < 3)
    minimal = false;
elseif (nargin < 2)
    error('[GNODE] Too few arguments');
end

try
    data_fields = cell(session.connector.validator.getData(object_type));
    attr_fields = cell(session.connector.validator.getAttributes(object_type));
    child_fields = cell(session.connector.validator.getChildren(object_type));
    parent_fields = cell(session.connector.validator.getParents(object_type));
catch
    error('[GNODE] Requested type not found in API spec');
end

prep_dummy = struct();

for i = 1:size(data_fields, 1)
    prep_dummy = setfield(prep_dummy, data_fields{i}, struct('units', '', 'data', 0));
end

for i = 1:size(attr_fields, 1)
    prep_dummy = setfield(prep_dummy, attr_fields{i}, '');
end

for i = 1:size(child_fields, 1)
    prep_dummy = setfield(prep_dummy, child_fields{i}, {});
end

for i = 1:size(parent_fields, 1)
    prep_dummy = setfield(prep_dummy, parent_fields{i}, {});
end

dummy = prep_dummy;

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