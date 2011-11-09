function set_up_classpath()
  %GNODE.SET_UP_CLASSPATH Initialises MATLAB JVM.
  % 
  %  No parameters. Uses toolboxdir() in order to determine location of the
  %  library JAR. Additionally, various JVM properties are set to sane
  %  standard values.

  % Settings
  toolbox_name = 'gnode';
  lib_file = 'client.jar';
  
  lib_path = fullfile(toolboxdir(toolbox_name), 'lib', lib_file);

  % Set classloader path to include library JAR
  javaaddpath(lib_path);
  clear java;

  % Fix inconsistency (till R2008b) involving illegal default proxy settings
  java.lang.System.clearProperty('https.proxyPort');
  java.lang.System.clearProperty('http.proxyPort');

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
