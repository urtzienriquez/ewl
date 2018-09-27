#just load the function:
source('./ewlR.R')

# enter the needed parameters
mass <- 56 # in grams
mass_m <- 54 # in grams
Vi <- 1.04 # air flow in the blank chamber
Ve <- 1.03 # air flow in the animal chamber
Vm <- 1.00 # air flow in the agar model chamber
RHi <- 0.036# relative humidity in blank chamber (expressed as a decimal fraction)
RHe <- 0.35 # relative humidity in animal chamber (expressed as a decimal fraction; e.g. 0.50 for a RH of 50%)
RHm <- 0.36 # relative humidity in agar model chamber (expressed as a decimal fraction; e.g. 0.50 for a RH of 50%)
Ti <- 22.7 # back-converted from VDi using the table for this example
Te <- 23.1 # idem
Tm <- 23.2
Tskin <- 19.3
Tskin_m <- 19.5

# and run!

# you have to choose a shape for the animal (frog or salamander) to compute the surface area
ewlR(mass, mass_m, Vi, Ve, Vm, RHi, RHe, RHm, 
     Ti, Te, Tm, Tskin, Tskin_m, morpho = "frog")

ewlR(mass, mass_m, Vi, Ve, Vm, RHi, RHe, RHm, 
     Ti, Te, Tm, Tskin, Tskin_m, morpho = "salam")


