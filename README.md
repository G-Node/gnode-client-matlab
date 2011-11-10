# G-Node MATLAB Toolbox

> Structured, efficient, and secure storage of experimental data and
> associated meta-information constitutes one of the most pressing
> challenges in modern neuroscience, and does so particularly in
> electrophysiology.

The G-Node MATLAB Toolbox (GMT) allows convenient access to electro-physiological
recordings stored in the G-Node [Data Store](http://portal.g-node.org/data) through
the MATLAB command line. Requirements are

* MATLAB R2008b or higher on any platform supporting Java (Linux, Mac, Windows), as well as a
* G-Node account (available [here](http://portal.g-node.org/data).

## Installation

GMT is installed like any other MATLAB toolbox. In order to get the latest stable
release (0.4b), follow these steps:

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