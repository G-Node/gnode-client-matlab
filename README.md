# G-Node MATLAB Toolbox

> The global scale of neuroinformatics offers unprecedented
> opportunities for scientific collaborations between and among
> experimental and theoretical neuroscientists. To fully harvest these
> possibilities, a set of coordinated activities is required that will
> improve three key ingredients of neuroscientific research: data
> access, data storage, and data analysis [...] ([Herz et al., 2008](http://www.g-node.org/publications/NN2436.pdf))

The G-Node MATLAB Toolbox (GMT) allows convenient access to electro-physiological
recordings stored in the G-Node [Data Store](http://portal.g-node.org/data) through
the MATLAB command line. Requirements are

* MATLAB R2008b or higher on any platform supporting Java (Linux, Mac, Windows), as well as a
* G-Node account (available [here](http://portal.g-node.org/data)).

## Installation

GMT is installed like any other MATLAB toolbox. In order to get the latest stable
release (0.41b), follow these steps:

1. [Download one of the provided archives from GitHub.](http://github.com/G-Node/gnode-client-matlab/downloads)
2. Unzip/untar the release to your MATLAB toolbox directory. In most cases, this
   corresponds to `$MATLAB_HOME/toolbox`. Your toolbox directory should now contain
   a folder `gnode`.
3. Adjust the account settings in the default configuration file
   (`$MATLAB_HOME/toolbox/gnode/default.json`):
   * Set `username` to the name of the G-Node account you want to use.
   * Set `password` to your password. (All transfer is mediated by a secure
     connection.)
   * Set `apiDefinition` to the supplied `requirements.json` file. For instance,
     if your `$MATLAB_HOME` corresponds to `/home/john/matlab/`, you
     should put `/home/john/matlab/toolbox/gnode/requirements.json`.
4. Open MATLAB.
5. Check that your installation was successful by typing `import gnode.*;` at the
   MATLAB prompt. If there are no errors, you can start using the toolbox.

If you want to track the development branch, follow these steps. NB,
release channel updates may break compatibility or introduce bugs.

1. Locate your MATLAB toolbox directory. In most cases, this corresponds
   to `$MATLAB_HOME/toolbox`.
2. Clone the git repository from GitHub via
   `git clone https://github.com/g-node/gnode-client-matlab.git`.
3. Proceed from `3` in the outline above.

## Getting started

Before using the toolbox, you need to set up MATLAB and initialize a session.

```matlab
% Move all toolbox functions to local namespace
import gnode.*;

% Preliminaries
set_up_classpath();

% Initialize session. 'default' will use the account settings specified
% during installation.
session = init('default');
```

Now, the toolbox is ready for use. A network connection to the G-Node
server is required for all download or upload operations.

```matlab
% Create a structure containing signal data

signal = make_dummy(session, 'analogsignal');

signal.name = 'My brand new signal';
signal.sampling_rate = struct('units', 'Hz', 'data', 12000);
signal.t_start = struct('units', 'ms', 'data', 0);
signal.signal = struct('units', 'mV', 'data', my_data);

% This returns the ID of the newly created object in
% the G-Node data store

new_object = create(session, signal);
```