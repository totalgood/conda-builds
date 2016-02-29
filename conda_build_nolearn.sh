#!/usr/bin/env bash
conda-env list
conda update anaconda
cd ~/src
mkdir conda-builds
cd conda-builds/
# create a nolearn meta.yml file from the pypi package (old version will need to be updated)
conda skeleton pypi nolearn
cd nolearn/

# this is not required, but I forked nolearn to bump the version up to 0.7, but never registerd it with pypi
cd ~/src
git clone git@github.com:totalgood/nolearn.git
cd nolearn/
# changed the version in docs/conf.py and setup.cfg and then tagged that commit with that version on github
git tag -a v$(python setup.py --version) -m 'master branch of nolearn on 2016-02-28 for Hack University Machine Learning Course'
# commit happened after the tag so that needs to be fixed in case anyone ever installs from the tg repo fork
git commit -am 'bump version and tag'
git push --tag
cd ../conda-builds/
# kept failing on missing packages, so I just kept diving down the rabbit hole to build conda packages for dependencies
conda build nolearn
anaconda search -t conda gdbn
pip search gdbn
conda skeleton pypi gdbn
conda build gdbn
conda build gnumpy
conda skeleton pypi gnumpy
conda build gnumpy
conda build gdbn
conda build nolearn
# tricky to get the 9.3 vs 9.4 older version of joblib used in gdbn and nolearn (I think)
conda build joblib --version 0.9.3
conda build joblib
conda install nose
conda build joblib
conda build nolearn
conda env export -n root --file=huml_environment.yml
conda install --file=huml_environment.yml 
# fix up the versions of everythin like six and joblib
nano environment.yml 
conda env create -n huml -f=`pwd`/huml_environment.yml
conda env update --upgrade -n huml -f=`pwd`/huml_environment.yml
# once the versions were correct and anaconda and conda were removed (since its not root), this worked
conda env update -n huml -f=`pwd`/huml_environment.yml
# OK we've got enough yaml files for github push
git init .
git add .
git status
git commit -am 'almost all the conda build packages required for nolearn'
git status
conda build nolearn
conda env update -n root -f=`pwd`/huml_environment.yml
conda install lasagna==0.2
anaconda search -t conda lasagna
more joblib/meta.yaml 
conda skeleton pypi theano
conda skeleton pypi lasagna
conda build theano
more huml_environment.yml | grep six
conda build theano
conda build lasagne
conda build nolearn
conda skeleton pypi tabulate
conda build tabulate
conda build tabulate
conda build nolearn
git commit -am 'build nolearn worked! a v0.7 exists on binstar/hobs'
git push
git remote add origin git@github.com:totalgood/conda-builds.git
git push -u origin master
git add .
git commit -am 'had to build theano, then tabulate, then lasagne and upload to hobs channel on anaconda'
git push
history | tail -n 1000 | cut -c 28- > conda_build_nolearn.sh 
