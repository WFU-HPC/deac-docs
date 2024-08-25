# PHY266 Documentation for Instructor

## Initial Python Environment

I will assume that the Python environment will be installed in,

```sh
/deac/phy/classes/phy266/python
```

You can then do the following steps to install everything to that location,

```sh
module load python/3.8.13

python3 -m venv /deac/phy/classes/phy266/python

source /deac/phy/classes/phy266/python/bin/activate # if you use bash, or
# source /deac/phy/classes/phy266/python/bin/activate.csh # if you use tcsh or csh
python3 -m pip install numpy matplotlib seaborn pandas scipy ipywidgets jupyter statsmodels keras scikit-learn google hdbscan
```

We will use Visual Studio Code to handle the Jupyter notebooks directly, so refer to the student documentation about setting that up.


## Installing new Python modules

If you want to add more Python modules to the environment, just follow the last two steps from above,

```sh
source /deac/phy/classes/phy266/python/bin/activate # if you use bash, or
# source /deac/phy/classes/phy266/python/bin/activate.csh # if you use tcsh or csh
python3 -m pip install new_package1 new_package2
```
