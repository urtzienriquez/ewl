
# ewlR function to calculate evaporative water loss and skin resistance
#
# PARAMETERS:
#
# mass: mass of frog/salamander in grams
# mass_m: mass of the animal's agar model in grams
# Vi: air flow in the empty chamber
# Ve: air flow in the animal chamber
# Vm: air flow in the agar model chamber
# RHi: relative humidity in empty chamber (expressed as decimal fraction; e.g. 0.50 for a RH of 50%)
# RHe: relative humidity in animal chamber (expressed as decimal fraction)
# RHm: relative humidity in agar model chamber (expressed as decimal fraction)
# Ti: temperature in empty chamber
# Te: temperature in animal chamber
# Tm: temperature in agar model chamber
# Tskin: animal's skin temperature
# Tskin_m: agar model's 'skin' (surface) temperature
# morpho: either 'frog' or 'salamander' (to compute the surface area; SA)

ewlR <- function(mass, mass_m, 
                 Vi, Ve, Vm,
                 RHi, RHe, RHm,
                 Ti, Te, Tm, Tskin, Tskin_m,
                 morpho=c('frog','salam')){
  
  # compute vapor density values from temperature using an equation:
  vapor_dens <- function(Tc){
    VD <- 5.018 + .32321*Tc + 8.1847 * 10^-3 * Tc^2 + 3.1243 * 10^-4 * Tc^3
    return(VD)
  }
  
  VDi <- vapor_dens(Ti)
  VDe <- vapor_dens(Te)
  VDs <- vapor_dens(Tskin)
  
  ######
  # TOTAL EVAPORATIVE WATER LOSS  (EWL)
  
  OMEGAe <- VDe * RHe # water vapor density in the animal chamber
  OMEGAi <- VDi * RHi # water vapor density in the blank chamber
  
  EWL <- Ve * OMEGAe - Vi * OMEGAi # evaporative water loss for the amph (mg min-1)
  
  
  ######
  # MASS SPECIFIC EVAPORATIVE WATER LOSS (M_EWL)
  M_EWL <- (EWL / mass) * 60 # This is in mg g-1 h-1
  
  
  ######
  # SURFACE AREA SPECIFIC EVAPORATIVE WATER LOSS (SA_EWL)
  #equations to compute SA
  
  # for an anuran
  if(morpho=='frog'){
    SA_func <- function(m){
      return(9.9 * (m^0.56))
    }
  }
  
  # for a urodele
  if(morpho=='salam'){
    SA_func <- function(m){
      return(8.42 * (m^0.694)) # Using the equation in Riddell et al 2017
    }
  }
  
  SA <- SA_func(mass)
  
  SA_wc <- SA*(2/3) # surface area at water conserving posture
  
  SA_EWL <- (EWL / SA_wc) * 60
  
  
  ######
  # CUTANEOUS RESISTANCE TO WATER LOSS 
  
  # for these we need to re-calculate all parameters but for the agar model.
  VDe_m <- vapor_dens(Tm)
  VDs_m <- vapor_dens(Tskin_m)
  
  OMEGAe_m <- VDe_m * RHm # water vapor density in the agar model chamber
  
  EWL_m <- Vm * OMEGAe_m - Vi * OMEGAi # evaporative water loss for the agar model
  
  SA_m <- SA_func(mass_m)
  
  SA_wc_m <- SA_m*(2/3) # surface area at water conserving posture
  SA_EWL_m <- (EWL_m / SA_wc_m) * 60
  
  # frog: rT
  VDD <- VDs - OMEGAe
  EWL_SA <- SA_EWL / 3.6 # this is just a conversion factor to convert to s cm-1
  
  rT <- VDD/EWL_SA
  
  # agar model: rb 
  VDD_m <- VDs_m - OMEGAe_m
  EWL_SA_m <- SA_EWL_m / 3.6 # this is just a conversion factor to convert to s cm-1
  
  rb <- VDD_m/EWL_SA_m
  
  rc <- rT - rb
  
  return(list(EWL=EWL, Mass_EWL=M_EWL, SurfArea_EWL=SA_EWL, Rc=rc))
}



