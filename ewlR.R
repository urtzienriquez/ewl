# parameters
# mass:

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
  VDe_m <- vapor_dens(Tm)
  VDs <- vapor_dens(Tskin)
  VDs_m <- vapor_dens(Tskin_m)
  
  # total evaporative water loss (EWL)
  OMEGAe <- VDe * RHe # water vapor density in the animal chamber
  OMEGAi <- VDi * RHi # water vapor density in the blank chamber
  OMEGAe_m <- VDe_m * RHm # water vapor density in the agar model chamber
  
  EWL <- Ve * OMEGAe - Vi * OMEGAi # evaporative water loss for the amph (mg min-1)
  EWL_m <- Vm * OMEGAe_m - Vi * OMEGAi # evaporative water loss for the agar model
  
  
  
  # mass specific evaporative water loss (M_EWL)
  M_EWL <- (EWL / mass) * 60 # This is in mg g-1 h-1
  M_EWL_m <- (EWL_m / mass_m) * 60
  
  # surface area specific evaporative water loss (SA_EWL)
  #equations to compute SA
  # for a amph:
  SA_frog <- function(m){
    return(9.9 * (m^0.56))
  }
  
  # salamander:
  SA_salam <- function(m){
    return(8.42 * (m^0.694)) # Using the equation in Riddell et al 2017
  }
  
  ifelse(morpho=='frog', SA <- SA_frog(mass), SA <- SA_salam(mass))
  
  ifelse(morpho=='frog', SA_m <- SA_frog(mass_m), SA_m <- SA_salam(mass_m))
  
  SA_wc <- SA*(2/3) # surface area at water conserving posture
  SA_wc_m <- SA_m*(2/3) # surface area at water conserving posture
  
  SA_EWL <- (EWL / SA_wc) * 60
  SA_EWL_m <- (EWL_m / SA_wc_m) * 60
  
  
  
  
  # cutaneous skin resistance to water loss
  
  # frog: rT
  VDD <- VDs - OMEGAe
  EWL_SA <- SA_EWL / 3.6
  
  rT <- VDD/EWL_SA
  
  # agar model: rb 
  VDD_m <- VDs_m - OMEGAe_m
  EWL_SA_m <- SA_EWL_m / 3.6
  
  rb <- VDD_m/EWL_SA_m
  
  rc <- rT - rb
  
  return(list(EWL=EWL, Mass_EWL=M_EWL, SurfArea_EWL=SA_EWL, Rc=rc))
}



