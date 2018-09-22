#just load the function:
source('./ewlR.R')

# enter the needed parameters
mass <- 56 # in grams
mass_m <- 56 # in grams
Vi <- 1.04 # air flow in the blank chamber
Ve <- 1.04 # air flow in the animal chamber
Ve_m <- 1.04 # air flow in the agar model chamber
RHi <- 0.036# relative humidity in blank chamber (expressed as a decimal fraction)
RHe <- 0.35 # relative humidity in animal chamber (expressed as a decimal fraction; e.g. 0.50 for a RH of 50%)
RHe_m <- 0.35 # relative humidity in agar model chamber (expressed as a decimal fraction; e.g. 0.50 for a RH of 50%)
#VDi <- 20.23 # Saturation vapor density in blank chamber (extracted from Smithsonian Table 108)
#VDe <- 20.58 # Saturation vapor density in animal chamber (extracted from Smithsonian Table 108)
#VDe_m <- 20.58 # Saturation vapor density in agar model chamber (extracted from Smithsonian Table 108)
#VDs <- 16.6
#VDs_m <- 16.6

# Now that we have an equation to convert temperature into vapor density, we don't need 
# the table. Just enter temperature values! :)

Ti <- 22.7 # back-converted from VDi using the table for this example
Te <- 23 # idem
Te_m <- 23
Tskin <- 19.3
Tskin_m <- 19.3

# and run!
# you have to choose a shape for the animal (frog or salamander) to compute the surface area
ewlR(mass, mass_m, Vi, Ve, Ve_m, RHi, RHe, RHe_m, 
     Ti, Te, Te_m, Tskin, Tskin_m, morpho = "frog")

ewlR(mass, mass_m, Vi, Ve, Ve_m, RHi, RHe, RHe_m, 
     Ti, Te, Te_m, Tskin, Tskin_m, morpho = "salam")

# in this case animals and agar models behave exactly the same (see parameters).
# that's why R=0. Hopefully, with real data we will have better resuts! :)
