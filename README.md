# Multipath Regression

Program developed for the Applied Project II subject of the MSc AS-NAT at ENAC. This program is used to test ant compare the performance of three different algorithms in estimating the mean of the Multipath error with respect to a number of features. The algorithms implemented are: a classical regression (using MATLAB's fitting toolbox), a gradient descent and a one-layer neural network.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Copy the raw data files inside the directory  `Data/` of the project.

### Installing

Before running the software for the first time, the data has to be prepared. This can be done with two functions depending on the data that is used:
 * If the data files contain the pseudorange error, the function used to read the data is `prepareDataPRE()`.
 * If the data files contain the multipath error, the function used to read the data is `prepareDataMPE()`.

These two functions remove the outliers and save all the data in one structure.

Change the directory in the corresponding function to match with the directory that contains the files, to do so search for the definition of the variable `directory`:
```
directory = 'Data/<your_file_or_folder>'
```
Choose the name of the output file that will contain the prepared data:

```
saveDirectory = 'Data/<name_of_file>'
```

## Running the tests

Choose the desired configuration in `Configuration/getConfig()`. Be sure to configure the data file name that has been previously set:

```
Config.Data.FileName = 'Data/<name_of_file>'
```

Then, run the function `main()`.

## Built With

* [MATLAB](https://www.mathworks.com/products/matlab.html)

## Authors

* **Andrea Bellés Ferreres** - [andreabelles](https://github.com/andreabelles)
* **Arnau Ochoa Bañuelos** - [arnauochoa](https://github.com/arnauochoa)

## Acknowledgments

* Some of the code that has been used is from the Machine Learning course in [Coursera](https://www.coursera.org/learn/machine-learning).
* Also thank our supervisors, Carl Milner ([carlatenac](https://github.com/carlatenac)) and Heekwon No ([nonokwon](https://github.com/nonokwon)).
