help([[
Load environment for running JEDI applications with OpenMPI.
]])

local pkgName    = myModuleName()
local pkgVersion = myModuleVersion()
local pkgNameVer = myModuleFullName()

conflict(pkgName)

load("gnu/7.3.0")
load("szip/2.1.1")
load("openmpi/3.1.2")

load("eigen/3.3.5")
load("boost/1_68_0")

load("ecbuild/2.9.3")

load("eckit/0.23.0")
load("fckit/jcsda-develop")

load("hdf5/1.10.3")
load("netcdf/4.6.1")

setenv("FC",  "mpif90")
setenv("CC",  "mpicc")
setenv("CXX", "mpicxx")

whatis("Name: ".. pkgName)
whatis("Version: ".. pkgVersion)
whatis("Category: Application")
whatis("Description: JEDI Environment with OpenMPI")
