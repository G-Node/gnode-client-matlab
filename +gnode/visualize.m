function h = visualize(objects)
%VISUALIZE Convenience function. Wraps plotting for single or multiple
%  analogsignals.

err_msg = '[GNODE] Please provide suitable objects of type analogsignal';

% Sanity checks
if ~iscell(objects)
    objects = {objects};
end

if any(cellfun(@(x) ~isstruct(x) || numel(strfind(x.id, 'analogsignal')) < 1, ...
        objects))
    error(err_msg);
end

if numel(objects) < 1
    error(err_msg);
end

% Plot
h = figure;

% Use first signal as reference
r_obj = objects{1};
r_length = length(r_obj.signal.data);
r_yunit = r_obj.signal.units;
r_sr = r_obj.sampling_rate.data;
r_xunit = r_obj.t_start.units;
r_offset = r_obj.t_start.data;

x_axis = linspace(r_offset, r_offset + r_length / r_sr * 1000, r_length);
data = zeros(r_length, length(objects));

for o = 1:length(objects)
    data(:, o) = objects{o}.signal.data(1:500);
end

plot(x_axis, data);
xlabel(sprintf('Time (%s)', r_xunit));
ylabel(sprintf('Data (%s)', r_yunit));

if numel(objects) == 1
    title(r_obj.name);
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