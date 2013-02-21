function res = validate(session, obj, object_type, strict)
%VALIDATE Performs object validation based on currently loaded
%object contract for the G-Node data store. NB, successful
%client-side validation does not guarantee successful server-side
%validation. Object type is guessed where possible; explicit
%specification should be used wherever feasible.
%
%Two validation types can be toggled: Negative, or permissive,
%validation only checks if all required fields are present.
%Positive, or strict, validation checks whether *only* admissible
%fields are present. If validation fails, the procedure attempts to
%deliver information about missing fields (where available).
%
%  validate(g, my_object) returns true iff object type can be
%  guessed and all required fields are present.
%
%  validate(g, my_object, 'segment') returns true iff all required
%  fields are present.
%
%  validate(g, my_object, 'segment', true) returns true iff all and
%  only admissible fields are members of the G-Node data store
%  object.

if (nargin == 3)

    strict = false;

elseif (nargin == 2)

    strict = false;
    import org.gnode.lib.matlab.*;

    try
        object_type = Helper.guessType(obj.id);
    catch
        error('[GNODE] Could not guess type. Needs specification');
    end

elseif (nargin < 2)

    error('[GNODE] Cannot peform validation sans object');

end

if (isfield(obj, 'id'))
    id = obj.id;
else
    id = 'UNKNOWN OBJECT';
end

% Negative:
required = cell(session.connector.validator.getRequired(object_type));

res = true;
fields = fieldnames(obj);

for i = 1:size(required, 1)

    if (~any(ismember(fields, required{i})))
        res = false;
        fprintf('[GNODE] %s: Required field absent (%s)\n', id, required{i});
    end
    
    if isempty(getfield(obj, required{i}))
        res = false;
        fprintf('[GNODE] %s: Required field empty (%s)\n', id, required{i});
    end

end

if (res)
%     fprintf('[GNODE] %s: All required fields present\n', id);
end

% Positive:
if (strict)

    all = cell(session.connector.validator.getAll(object_type));
    all{end+1} = 'id';
    x = setxor(fieldnames(obj), all);

    if (isempty(x))

        fprintf('[GNODE] %s: Only and all valid fields present\n', id);
        res = true;

    else

        problem_strings = '';

        for i = 1:size(x, 1)
            problem_strings = [problem_strings char(x(i))];
        end

        fprintf('[GNODE] %s: Invalid or missing fields (%s)\n', id, problem_strings);
        res = false;

    end

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