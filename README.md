# Evaporative Water Loss

R code (ewlR function) to compute evaporative water loss and skin resistance of frogs or salamanders measured in air flow chambers (see REF for experimental protocol). I want to thank Keith A. Christian for help with calculations. 

These parameters are required:

`mass`: mass of frog/salamander in grams

`mass_m`: mass of the animal's agar model in grams

`Vi`: air flow in the empty chamber

`Ve`: air flow in the animal chamber

`Vm`: air flow in the agar model chamber

`RHi`: relative humidity in empty chamber (expressed as decimal fraction; e.g. 0.50 for a RH of 50%)

`RHe`: relative humidity in animal chamber (expressed as decimal fraction)

`RHm`: relative humidity in agar model chamber (expressed as decimal fraction)

`Ti`: temperature in empty chamber

`Te`: temperature in animal chamber

`Tm`: temperature in agar model chamber

`Tskin`: animal's skin temperature

`Tskin_m`: agar model's 'skin' (surface) temperature

`morpho`: either 'frog' or 'salamander' (to compute the surface area; SA)

## Using the function
Once you have all the required parameters, just load the function and it will return a list with **Evaporative Water Loss** (EWL), **Mass Specific Evaporative Water Loss** (Mass_EWL), **Surface Area Specific Evaporative Water Loss** (SurfArea_EWL), and **skin resistance to water loss** (Rc). See next section for details of the calculations. 

```{r}
source('./ewlR.R')

ewlR(mass = 56, mass_m = 54, Vi = 1.04, Ve = 1.03, Vm = 1.00, 
     RHi = 0.036, RHe = 0.35, RHm = 0.36,
     Ti = 22.7, Te = 23.1, Tm = 23.2, Tskin = 19.3, Tskin_m = 19.5, morpho='frog')

$EWL
[1] 6.706037

$Mass_EWL
[1] 7.18504

$SurfArea_EWL
[1] 6.398645

$Rc
[1] 0.159015

```

## EWL calculations explained

* __Estimating saturation vapor density__

I have implemented the following equation to calculate saturation vapor density at different temperatures:

*VD* = 5.018 + 0.32321 &times; *T<sub>c</sub>* + 8.1847 &times; 10<sup>-3</sup> &times; *T<sub>c</sub>*<sup>2</sup> + 3.1243 &times; 10<sup>-4</sup> &times; *T<sub>c</sub>*<sup>3</sup>

*VD* stands for saturation vapor density and *T<sub>c</sub>* for temperature in degrees Celsius. The equation was taken from (REF).


![VD](./images/VD_plot.png)

* __Estimating surface area__

The `morpho` parameter determines which equation is just to calculate the surface area of the individual based on its mass. 

To estimate the surface area of a frog/toad, I have implemented this equation:

9.9 &times; (*m*<sup>0.56</sup>); *m stands for mass (in mg)*

To estimate the surface area of a salamander, I have implemented this equation taken from Riddell *et al.* 2017:

8.42 &times; (m<sup>0.694</sup>); *m stands for mass (in mg)*

**NOTE: if you have the equation for your particular species, you can just change the equation (or parameters) within the ewlR function.**

## References

Riddell *et al.* 2017. Physical calculations of resistance to water loss improve predictions of species range models. *Ecological Monographs* **87(1): 21–33**

