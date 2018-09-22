# Evaporative Water Loss

R code to compute evaporative water loss and skin resistance of frogs or salamanders measured in air flow chambers (see REF for experimental protocol). I want to thank Keith A. Christian for help with calculations. 

These parameters are required:

**1. mass:** mass of frog/salamander in grams

**2. mass_m:** mass of the animal's agar model in grams

**3. V<sub>i</sub>:** air flow in the blank chamber

**Ve** air flow in the animal chamber

Ve_m <- 1.04 # air flow in the agar model chamber
RHi <- 0.036# relative humidity in blank chamber (expressed as a decimal fraction)
RHe <- 0.35 # relative humidity in animal chamber (expressed as a decimal fraction; e.g. 0.50 for a RH of 50%)
RHe_m <- 0.35 # relative humidity in agar model chamber (expressed as a decimal fraction; e.g. 0.50 for a RH of 50%)
#VDi <- 20.23 # Saturation vapor density in blank chamber (extracted from Smithsonian Table 108)
#VDe <- 20.58 # Saturation vapor density in animal chamber (extracted from Smithsonian Table 108)
#VDe_m <- 20.58 # Saturation vapor density in agar model chamber (extracted from Smithsonian Table 108)
#VDs <- 16.6
#VDs_m <- 16.6