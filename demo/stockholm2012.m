% Stockholm 2012
%
% Demonstration of MATLAB client

%% Set-up

% We simply add the toolbox directory to the MATLAB search path,
% making all gnode.* functions available at the CLI.

addpath('/path/to/gnode/toolbox/');

% Invoking this function sets the correct classpath for the included
% JVM components.

gnode.set_up_classpath();

% Now we're ready to create a G-Node session object. It encapsulates
% all user data, server info etc. Multiple parallel sessions (e.g.,
% different users with access to required data) are maintained simply
% by creating multiple session objects.
%
% Configurations are set in JSON format; see documentation for specific
% instructions on how to set up a configuration template. By specifying
% 'default' or nothing at all, we fall back on the supplied file.

g = gnode.init('default');

%% Data discovery and visualization

% Let's see what's available. Having uploaded a datafile, we
% should expect a number of 'analogsignal' objects. Here we specify a
% maximum number of 20 requested objects with an offset of 10 objects.

my_signals = gnode.get_list(g, 'analogsignal', 20, 10);
my_signals

% gnode.get(...) allows us to download a single object or multiple
% objects simultaneously.

signal_one = gnode.get(g, my_signals{1});

% Data objects are simple structures containing general information,
% metadata and actual *data*.
signal_one
signal_one.name
signal_one.signal.data

% Let's have a closer look at our signal. gnode.visualize(...) 
% automatically adjusts the axes, adds labels and a title, etc. if
% it encounters an appropriate plottable entity.

gnode.visualize(signal_one);

% We can do the same thing with multiple objects.

close all;
gnode.visualize(gnode.get(g, my_signals));