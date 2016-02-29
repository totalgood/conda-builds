# Conda Builds

The Rabbit-Hole of conda build, run, test requirements to be able to install nolearn from source (version >0.6.1adev >=0.7.0).

And a reminder history dump for all the stuff required. 

## Build for other than Linux 64

My build on the hobs anaconda channel is for Linux 64 (Ubuntu).

If you're on another platform (Windows, OSX, Linux 32) and want to build the conda package, this might work...

```bash
git clone git@github.com:totalgood/conda-builds.git
conda config --add channels hobs
# you may need to also add your own channel by registering at anaconda:
# https://anaconda.org/account/register
conda config --set anaconda_upload yes
conda build gnumpy
# ...
conda build gdb
conda build theano
conda build lasagne
conda build nolearn
```

Though I'm sure their are compiler and development packages you'll need to install to get it to all work.
