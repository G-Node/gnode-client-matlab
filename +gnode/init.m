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

import gnode.*;

% set_up_classpath();

import org.gnode.lib.client.*;
import org.gnode.lib.conf.*;
import org.gnode.lib.util.Network;

% First, check connection:
if ~Network.check()
   error("[GNODE] Network not available; please check internet connection.");
end

% Settings
config_file = 'default.json';
default_config_location = [fileparts(mfilename('fullpath')) '/../' config_file];

% Determine intended configuration source
if (nargin == 1)

    if (strcmp(filename, 'default'))
        settings = get_default(default_config_location);
    else
        settings_some = ConfigurationReader.fromFile(filename);
        try
            settings = settings_some.get();
        catch
            settings = get_default();
        end
    end

elseif (nargin == 3)

    username = filename;

    default_settings = get_default(default_config_location);
    settings = ConfigurationReader.create(username, password, ...
          server, ...
          default_settings.port, ...
          default_settings.path, ...
          default_settings.apiDefinition, ...
          default_settings.caching, ...
          default_settings.db);

else

    settings = get_default(default_config_location);

end

try
    t = TransferManager(settings);
catch
    error('[GNODE] Could not initialize session from specified configuration');
end

session.connector = t; % Store transfer manager
session.settings = settings; % Keep configuration
session.logontime = clock;

end

% Helper
function default_configuration = get_default(location)

    import org.gnode.lib.conf.*; % Scope issue: reimport necessary
    settings_some = ConfigurationReader.fromFile(location);

    try
        settings = settings_some.get();
    catch
        error('[GNODE] Could not initialize from configuration');
    end

    default_configuration = settings;

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
