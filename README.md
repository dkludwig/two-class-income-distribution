# Data and code for ["Physics-inspired analysis of the two-class income distribution in the USA in 1983-2018"](https://arxiv.org/abs/2110.03140)
Please read the included [supplement](https://github.com/dkludwig/two-class-income-distribution/blob/main/supplement.pdf) file, which describes the dataset and fitting algorithms in greater detail than in the main paper. The organization of this repository is described below: 
## data 
The IRS income and tax distributional datasets are stored here in separate .CSV files for each year. This folder also contains a file with the annual averages of the national CPI-U from 1913-2020, `cpi.csv`, as well as a file containing all the calculated parameters used in the figures, `params.csv`
## analysis 
All procedures used to calculate the parameters in the main paper are in separate Matlab function .m files. The three `import*.m` functions take in a path to a .CSV data file and output a Matlab table object. These tables are taken as input to the `find*.m` files, which calculate the parameters. The `calculateall.m` script runs each of the `find*.m` functions for each of the years 1983-2018 and assigns to the variable `params` a table with all the calculated parameters; this is the same table that is already provided in the data folder. Note that the `calculateall.m` script should be run where it is; no need to move it to the data directory.
## figures
Each of the eight figures in the main paper is generated by its own `fig*.m` script. As with the `calculateall.m` script, the `fig*.m` scripts should all be run where they are.
