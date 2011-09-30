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

function session = init(filename, password, server)
  %INIT Creates a G-Node data store session, returning a *structure*
  %that is passed to most G-Node utility methods.
  %
  %  g = init('DEFAULT') returns a session g defaulting to standard
  %  settings. This configuration can be found (and, if necessary,
  %  modified) under $TBDIR/default.json.
  %
  %  g = init(username, password, server) returns a session g using
  %  specified authentication/server settings but defaulting to
  %  $TBDIR/default.json for everything else.
  %
  %  g = 

  import gnode.*;

  set_up_classpath();

  import org.gnode.lib.client.*;
  import org.gnode.lib.conf.*;

  if (nargin == 1)

    if (strcmp(filename, 'default'))
      filename = '/home/aleonhardt/gnode/aljoscha.json';
    end
  
    settings_some = ConfigurationReader.fromFile(filename);
    try
      settings = settings_some.get();
    catch
      settings = Default.CONFIGURATION;
    end

  elseif (nargin == 3)

    c = Default.CONFIGURATION;
    settings = ConfigurationReader.create(filename, password, server, c.port, c.path, c.apiDefinition, c.caching, c.db);

  else

    settings = Default.CONFIGURATION;

  end
	 
  t = TransferManager(settings);

  session.connector = t;
  session.settings = settings;

end
