%% STOCKHOLM (APRIL 2012)
% --------------------
% G-NODE MATLAB CLIENT
% DEMO

%% Set-up

% We add the toolbox directory to the MATLAB search path,
% making all gnode.* functions available at the CLI.

addpath('/opt/gnode-client-matlab/');

% Invoking this function sets the correct classpath for the included
% JVM components.

clear all;
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
% maybe metadata and actual *data*.

signal_one
signal_one.name
gnode.list_metadata(g, signal_one);
signal_one.signal.data

% Let's have a closer look at our signal. gnode.visualize(...) 
% automatically adjusts the axes, adds labels and a title, etc. if
% it encounters an appropriate plottable entity.

gnode.visualize(signal_one);

% We can do the same thing with multiple objects.

close all;
gnode.visualize(gnode.get(g, my_signals));

%% Create metadata

% As we've seen, our objects are still without any metadata. Time to
% change that. First, we create a section containing our properties and
% values:

my_section = gnode.make_dummy(g, 'sections');
my_section

% It's empty. Let's add stuff.

my_section.name = 'Stimulus conditins';
my_section.description = 'This section contains all features of our stimuli';

% With one command, we can push our section to the server:

my_section = gnode.get_created(g, my_section);
my_section

% There's a spelling error in the name. Let's fix that.

my_section.name = 'Stimulus conditions';
my_section = gnode.get_updated(g, my_section);
my_section

% All in order... Now for some properties and values.

prop_color = gnode.make_dummy(g, 'properties');
prop_color.name = 'Stimulus Color';
prop_color.definition = 'Colour of the moving dot';
prop_color = gnode.assign(prop_color, my_section);
prop_color = gnode.get_created(g, prop_color);

prop_vel = gnode.make_dummy(g, 'properties');
prop_vel.name = 'Stimulus Velocity';
prop_vel.definition = 'Constant velocity of the moving dot';
prop_vel = gnode.assign(prop_vel, my_section);
prop_vel = gnode.get_created(g, prop_vel);

val_red = gnode.make_dummy(g, 'values');
val_red.data = 'Red';

% Of course, values should belong to properties. Let's connect these:

val_red = gnode.assign(val_red, prop_color);
val_red = gnode.get_created(g, val_red);

% Same for blue.

val_blue = gnode.make_dummy(g, 'values');
val_blue.data = 'Blue';
val_blue = gnode.assign(val_blue, prop_color);
val_blue = gnode.get_created(g, val_blue);

%% Tagging

% We know that every other analogsignal from #200 was recorded with a
% red stimulus. So let's add appropriate metadata to appropriate data.
% First, we need the analogsignals in question.

signals = gnode.get_list(g, 'analogsignal', 100, 500);
red_signals = gnode.get(g, signals(1:2:length(signals)));

gnode.visualize(red_signals);

% None of these possess any metadata so far.

gnode.list_metadata(g, signals{1});

% Now we can assign and update.

red_signals = gnode.assign_metadata(red_signals, val_red);
cellfun(@(signal) gnode.update(g, signal), red_signals);

% And it worked:

gnode.list_metadata(g, signals{6});

%% Add a little structure

% A collection of analogsignals seems chaotic. Let's add some structure
% to the proceedings by establishing a recordingchannel:

rc1 = gnode.make_dummy(g, 'recordingchannel');
rc1.name = 'Electrode #1';
rc1 = gnode.get_created(g, rc1);

% Our first 50 signals were recorded with this electrode, so let's add
% them.

rc1_signals = gnode.get(g, signals(1:50));
rc1_signals = gnode.assign(rc1_signals, rc1);

cellfun(@(signal) gnode.update(g, signal), rc1_signals);

% This seems a tad cleaner.

gnode.clear_cache(g);
rc1 = gnode.get(g, rc1.id);
rc1.analogsignal_set

%% Search

% What if we want to share all AS in RC1 recorded under red stimulus
% conditions with our colleague Ray?

rays_data = gnode.get_search(g, 'analogsignal', {rc1 val_red});
length(rays_data)

% 25 -- as expected... Now let's turn that into a quick plot and attach
% a segment:

gnode.visualize(gnode.get(g, rays_data));

my_segment = gnode.make_dummy(g, 'segment');
my_segment.name = 'Data for Ray';
my_segment = gnode.get_created(g, my_segment);

rays_signals = gnode.assign(gnode.get(g, rays_data), my_segment);
cellfun(@(signal) gnode.update(g, signal), rays_signals);

%% Sharing

% One simple command, and Ray can access all 25 signals from his
% environment.

gnode.share(g, my_segment, 'ray', 1, 1);

%% Finish session

% When all's said and done, just shut down the session object. All progress
% and data is, of course, stored in the cloud. Next time you open
% your MATLAB prompt, you can continue where you left off.

gnode.shutdown(g);