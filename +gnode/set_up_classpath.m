%GNODE.SET_UP_CLASSPATH Initialises MATLAB JVM.
% 
%  No parameters. Uses toolboxdir() in order to determine location of the
%  library JAR. Additionally, various JVM properties are set to sane
%  standard values.

function set_up_classpath()

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
