help([[
]])

local pkgName    = myModuleName()
local pkgVersion = myModuleVersion()
local pkgNameVer = myModuleFullName()

conflict(pkgName)

local opt = os.getenv("OPT") or "/opt/modules"

local base = pathJoin(opt,pkgVersion)

local pythonExtras = pathJoin(opt,"python-extras/lib/python2.7/site-packages")

prepend_path("PATH", pathJoin(base,"bin"))
prepend_path("PYTHONPATH", pythonExtras)

whatis("Name: ".. pkgName)
whatis("Version: " .. pkgVersion)
whatis("Category: Software")
whatis("Description: Anaconda Python 2 Distribution")
