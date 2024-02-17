# MEPSDatasets.jl 

MEPSDatasets.jl is a Julia package to access MEPS data from Met Norway. See the [catalog](https://thredds.met.no/thredds/catalog/meps25epsarchive/catalog.html) for available ensemble and deterministic data. 

## Installation

```julia
using Pkg
Pkg.add("MEPSDatasets")
```

## Usage

* To get todays 00 UTC ENS data  

  ```julia
  julia> using MEPSDatasets,Dates
  julia> dtg = DateTime(today())    
  julia> ds = ENSds(dtg)           
  ```

  Index the dataset like  e.g. 

  ```julia
  julia> ds["air_temperature_2m"]
  air_temperature_2m (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height1 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Screen level temperature (T2M)
     standard_name        = air_temperature
     units                = K
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]
  ```

  Use `keys(ds)` to see available keys. Make sure to read the performance tips [here](https://alexander-barth.github.io/NCDatasets.jl/stable/performance/).

* To get the dataset for the control run use

  ```julia
  julia> ds = CTLds(dtg)
  ```

* To create a dataset for several days use e.g. 

  ```julia
  dtgbeg =  dtg-Day(7)
  dtgrange = dtgbeg:Hour(6):dtg
  ds = ENSds(dtgrange) 
  ```

  Data will be aggregated over the `forecast_reference_time` dimension, e.g. 

  ```julia  
  julia> ds["air_temperature_2m"]
  air_temperature_2m (949 × 1069 × 30 × 1 × 62 × 29)
    Datatype:    Union{Missing, Float32}
    Dimensions:  x × y × ensemble_member × height1 × time × forecast_reference_time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Screen level temperature (T2M)
     standard_name        = air_temperature
     units                = K
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]
  ```


## Example ENS dataset


```
Dataset: https://thredds.met.no/thredds/dodsC/meps25epsarchive/2024/02/17/meps_lagged_6_h_subset_2_5km_20240217T00Z.nc
Group: /

Dimensions
   time = 62
   ensemble_member = 30
   height0 = 1
   height1 = 1
   height2 = 1
   height_above_msl = 1
   hybrid = 1
   isotherm_0C_level = 1
   mean_sea_level = 1
   pressure = 6
   surface = 1
   x = 949
   y = 1069

Variables
  time   (62)
    Datatype:    DateTime (Float64)
    Dimensions:  time
    Attributes:
     long_name            = time
     standard_name        = time
     units                = seconds since 1970-01-01 00:00:00 +00:00
     _ChunkSizes          = 1

  forecast_reference_time  
    Attributes:
     units                = seconds since 1970-01-01 00:00:00 +00:00
     standard_name        = forecast_reference_time

  ensemble_member   (30)
    Datatype:    Int16 (Int16)
    Dimensions:  ensemble_member
    Attributes:
     long_name            = ensemble run number
     standard_name        = realization
     _CoordinateAxisType  = Ensemble
     _ChunkSizes          = 30

  mean_sea_level   (1)
    Datatype:    Int16 (Int16)
    Dimensions:  mean_sea_level
    Attributes:
     description          = mean sea level
     long_name            = mean_sea_level
     positive             = up
     units                = m
     _ChunkSizes          = 1

  surface   (1)
    Datatype:    Int16 (Int16)
    Dimensions:  surface
    Attributes:
     description          = ground or water surface
     long_name            = surface
     positive             = up
     units                = m
     _ChunkSizes          = 1

  pressure   (6)
    Datatype:    Float32 (Float32)
    Dimensions:  pressure
    Attributes:
     description          = pressure
     long_name            = pressure
     standard_name        = air_pressure
     positive             = down
     units                = hPa
     _ChunkSizes          = 6

  height_above_msl   (1)
    Datatype:    Float32 (Float32)
    Dimensions:  height_above_msl
    Attributes:
     description          = height above MSL
     long_name            = height
     positive             = up
     units                = m
     _ChunkSizes          = 1

  height0   (1)
    Datatype:    Float32 (Float32)
    Dimensions:  height0
    Attributes:
     description          = height above ground
     long_name            = height
     positive             = up
     units                = m
     _ChunkSizes          = 1

  height1   (1)
    Datatype:    Float32 (Float32)
    Dimensions:  height1
    Attributes:
     description          = height above ground
     long_name            = height
     positive             = up
     units                = m
     _ChunkSizes          = 1

  height2   (1)
    Datatype:    Float32 (Float32)
    Dimensions:  height2
    Attributes:
     description          = height above ground
     long_name            = height
     positive             = up
     units                = m
     _ChunkSizes          = 1

  hybrid   (1)
    Datatype:    Float64 (Float64)
    Dimensions:  hybrid
    Attributes:
     standard_name        = atmosphere_hybrid_sigma_pressure_coordinate
     formula              = p(n,k,j,i) = ap(k) + b(k)*ps(n,j,i)
     formula_terms        = ap: ap b: b ps: surface_air_pressure p0: p0
     long_name            = atmosphere_hybrid_sigma_pressure_coordinate
     positive             = down
     _ChunkSizes          = 1

  p0  
    Attributes:
     units                = Pa

  ap   (1)
    Datatype:    Float64 (Float64)
    Dimensions:  hybrid
    Attributes:
     units                = Pa
     _ChunkSizes          = 1

  b   (1)
    Datatype:    Float64 (Float64)
    Dimensions:  hybrid
    Attributes:
     units                = 1
     _ChunkSizes          = 1

  isotherm_0C_level   (1)
    Datatype:    Int16 (Int16)
    Dimensions:  isotherm_0C_level
    Attributes:
     description          = level of 0degreeC isotherm
     long_name            = isotherm 0C
     positive             = up
     _ChunkSizes          = 1

  projection_lambert  
    Attributes:
     grid_mapping_name    = lambert_conformal_conic
     standard_parallel    = [63.3, 63.3]
     longitude_of_central_meridian = 15.0
     latitude_of_projection_origin = 63.3
     earth_radius         = 6.371e6

  x   (949)
    Datatype:    Float32 (Float32)
    Dimensions:  x
    Attributes:
     long_name            = x-coordinate in Cartesian system
     standard_name        = projection_x_coordinate
     units                = m
     _ChunkSizes          = 949

  y   (1069)
    Datatype:    Float32 (Float32)
    Dimensions:  y
    Attributes:
     long_name            = y-coordinate in Cartesian system
     standard_name        = projection_y_coordinate
     units                = m
     _ChunkSizes          = 1069

  longitude   (949 × 1069)
    Datatype:    Float64 (Float64)
    Dimensions:  x × y
    Attributes:
     units                = degree_east
     long_name            = longitude
     standard_name        = longitude
     _ChunkSizes          = Int32[1069, 949]

  latitude   (949 × 1069)
    Datatype:    Float64 (Float64)
    Dimensions:  x × y
    Attributes:
     units                = degree_north
     long_name            = latitude
     standard_name        = latitude
     _ChunkSizes          = Int32[1069, 949]

  air_temperature_ml   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × hybrid × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Air temperature model levels
     standard_name        = air_temperature
     units                = K
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  air_temperature_0m   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Surface temperature (T0M)
     standard_name        = air_temperature
     units                = K
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  surface_geopotential   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Surface geopotential (fis)
     standard_name        = surface_geopotential
     units                = m^2/s^2
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  liquid_water_content_of_surface_snow   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Snow Water Equivivalent (SWE)
     standard_name        = liquid_water_content_of_surface_snow
     units                = kg/m^2
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  x_wind_pl   (949 × 1069 × 30 × 6 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × pressure × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Wind along x-coordinate on pressure levels
     standard_name        = x_wind
     units                = m/s
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  integral_of_surface_net_downward_shortwave_flux_wrt_time   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Accumulated net downward surface SW radiation
     standard_name        = integral_of_surface_net_downward_shortwave_flux_wrt_time
     units                = W s/m^2
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  y_wind_pl   (949 × 1069 × 30 × 6 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × pressure × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Wind along y-coordinate on pressure levels
     standard_name        = y_wind
     units                = m/s
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  air_temperature_pl   (949 × 1069 × 30 × 6 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × pressure × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Air temperature pressure levels
     standard_name        = air_temperature
     units                = K
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  integral_of_surface_downward_sensible_heat_flux_wrt_time   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Accumulated downwelling surface sensible heat flux
     standard_name        = integral_of_surface_downward_sensible_heat_flux_wrt_time
     units                = W s/m^2
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  downward_eastward_momentum_flux_in_air   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Momentum flux x-direction
     standard_name        = downward_eastward_momentum_flux_in_air
     units                = N/m^2
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  downward_northward_momentum_flux_in_air   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Momentum flux y-direction
     standard_name        = downward_northward_momentum_flux_in_air
     units                = N/m^2
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  integral_of_surface_downwelling_shortwave_flux_in_air_wrt_time   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Accumulated surface SW downwelling radiation
     standard_name        = integral_of_surface_downwelling_shortwave_flux_in_air_wrt_time
     units                = W s/m^2
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  integral_of_surface_downwelling_longwave_flux_in_air_wrt_time   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Accumulated surface LW downwelling radiation
     standard_name        = integral_of_surface_downwelling_longwave_flux_in_air_wrt_time
     units                = J/m^2
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  surface_air_pressure   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Surface air pressure
     standard_name        = surface_air_pressure
     units                = Pa
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  air_temperature_2m   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height1 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Screen level temperature (T2M)
     standard_name        = air_temperature
     units                = K
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  relative_humidity_2m   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height1 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Screen level relative humidity (RH2M)
     standard_name        = relative_humidity
     units                = 1
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  x_wind_10m   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height2 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = 10 metre wind along x-coordinate (U10M)
     standard_name        = x_wind
     units                = m/s
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  y_wind_10m   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height2 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = 10 metre wind along y-coordinate (V10M)
     standard_name        = y_wind
     units                = m/s
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  cloud_area_fraction   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Total cloud cover (TCC)
     standard_name        = cloud_area_fraction
     units                = 1
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  turbulent_kinetic_energy_pl   (949 × 1069 × 30 × 6 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × pressure × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Turbulent kinetic energy (TKE)
     metno_name           = turbulent_kinetic_energy
     units                = m^2/s^2
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  high_type_cloud_area_fraction   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Cloud cover of high clouds (HCC)
     standard_name        = high_type_cloud_area_fraction
     units                = 1
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  medium_type_cloud_area_fraction   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Cloud cover of medium height clouds (MCC)
     standard_name        = medium_type_cloud_area_fraction
     units                = 1
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  low_type_cloud_area_fraction   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Cloud cover of low clouds (LCC)
     standard_name        = low_type_cloud_area_fraction
     units                = 1
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  geopotential_pl   (949 × 1069 × 30 × 6 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × pressure × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Geopotential pressure levels
     standard_name        = geopotential
     units                = m^2/s^2
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  atmosphere_convective_inhibition   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Atmosphere convective inhibition (CIN)
     standard_name        = atmosphere_convective_inhibition
     units                = J/kg
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  relative_humidity_pl   (949 × 1069 × 30 × 6 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × pressure × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Relative humidity pressure levels
     standard_name        = relative_humidity
     units                = 1
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  atmosphere_boundary_layer_thickness   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Height of the PBL
     standard_name        = atmosphere_boundary_layer_thickness
     units                = m
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  upward_air_velocity_pl   (949 × 1069 × 30 × 6 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × pressure × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Vertical vind pressure levels
     standard_name        = upward_air_velocity
     units                = m/s
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  air_pressure_at_sea_level   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height_above_msl × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Mean Sea Level Pressure (MSLP)
     standard_name        = air_pressure_at_sea_level
     units                = Pa
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  lwe_thickness_of_atmosphere_mass_content_of_water_vapor   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × surface × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Precipitable water
     standard_name        = lwe_thickness_of_atmosphere_mass_content_of_water_vapor
     units                = m
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  precipitation_amount_acc   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Accumulated total precipitation
     standard_name        = precipitation_amount
     units                = kg/m^2
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  snowfall_amount_acc   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Total accumulated solid precipitation (snow+graupel+hail)
     standard_name        = snowfall_amount
     units                = kg/m^2
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  wind_speed_of_gust   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height2 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Wind gust
     standard_name        = wind_speed_of_gust
     units                = m/s
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  altitude_of_0_degree_isotherm   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × isotherm_0C_level × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Altitude of 0-degree isotherm
     units                = m
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  fog_area_fraction   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Fog
     metno_name           = fog_area_fraction
     units                = 1
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  SFX_TICE_01   (949 × 1069 × 30 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × time
    Attributes:
     standard_name        = sea_ice_temperature
     long_name            = Sea_ice_temperature_in_layer_1
     _FillValue           = 9.96921e36
     institution          = MetCoOp
     model                = Variable from the External Surface model SURFEX
     comment              = Variable is named as in source code but with the prefix SFX_
     references           = https://www.umr-cnrm.fr/surfex/
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1069, 949]

  SFX_TICE_02   (949 × 1069 × 30 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × time
    Attributes:
     standard_name        = sea_ice_temperature
     long_name            = Sea_ice_temperature_in_layer_2
     _FillValue           = 9.96921e36
     institution          = MetCoOp
     model                = Variable from the External Surface model SURFEX
     comment              = Variable is named as in source code but with the prefix SFX_
     references           = https://www.umr-cnrm.fr/surfex/
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1069, 949]

  SFX_SIC   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × mean_sea_level × time
    Attributes:
     standard_name        = sea_ice_area_fraction
     long_name            = Sea_ice_fraction
     _FillValue           = 9.96921e36
     institution          = MetCoOp
     model                = Variable from the External Surface model SURFEX
     comment              = Variable is named as in source code but with the prefix SFX_
     references           = https://www.umr-cnrm.fr/surfex/
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  SFX_SST   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × mean_sea_level × time
    Attributes:
     units                = K
     standard_name        = sea_surface_temperature
     long_name            = Sea Surface Temperature (SST)
     _FillValue           = 9.96921e36
     institution          = MetCoOp
     model                = Variable from the External Surface model SURFEX
     comment              = Variable is named as in source code but with the prefix SFX_
     references           = https://www.umr-cnrm.fr/surfex/
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  SFX_X001TG1   (949 × 1069 × 30 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × time
    Attributes:
     units                = K
     standard_name        = soil_temperature
     long_name            = Soil temperature layer 1 for patch 1
     _FillValue           = 9.96921e36
     institution          = MetCoOp
     model                = Variable from the External Surface model SURFEX
     comment              = Variable is named as in source code but with the prefix SFX_
     references           = https://www.umr-cnrm.fr/surfex/
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1069, 949]

  SFX_X002TG1   (949 × 1069 × 30 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × time
    Attributes:
     units                = K
     standard_name        = soil_temperature
     long_name            = Soil temperature layer 1 for patch 2
     _FillValue           = 9.96921e36
     institution          = MetCoOp
     model                = Variable from the External Surface model SURFEX
     comment              = Variable is named as in source code but with the prefix SFX_
     references           = https://www.umr-cnrm.fr/surfex/
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1069, 949]

  SFX_X001TG2   (949 × 1069 × 30 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × time
    Attributes:
     units                = K
     standard_name        = soil_temperature
     long_name            = Soil temperature layer 2 for patch 1
     _FillValue           = 9.96921e36
     institution          = MetCoOp
     model                = Variable from the External Surface model SURFEX
     comment              = Variable is named as in source code but with the prefix SFX_
     references           = https://www.umr-cnrm.fr/surfex/
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1069, 949]

  SFX_X002TG2   (949 × 1069 × 30 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × time
    Attributes:
     units                = K
     standard_name        = soil_temperature
     long_name            = Soil_temp_layer_2
     _FillValue           = 9.96921e36
     institution          = MetCoOp
     model                = Variable from the External Surface model SURFEX
     comment              = Variable is named as in source code but with the prefix SFX_
     references           = https://www.umr-cnrm.fr/surfex/
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1069, 949]

  SFX_X001WG1   (949 × 1069 × 30 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × time
    Attributes:
     units                = m3/m3
     long_name            = Soil moisture layer 1 for nature tile for patch 1
     _FillValue           = 9.96921e36
     institution          = MetCoOp
     model                = Variable from the External Surface model SURFEX
     comment              = Variable is named as in source code but with the prefix SFX_
     references           = https://www.umr-cnrm.fr/surfex/
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1069, 949]

  SFX_X002WG1   (949 × 1069 × 30 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × time
    Attributes:
     units                = m3/m3
     long_name            = Soil moisture later 1 for nature tile for patch 2
     _FillValue           = 9.96921e36
     institution          = MetCoOp
     model                = Variable from the External Surface model SURFEX
     comment              = Variable is named as in source code but with the prefix SFX_
     references           = https://www.umr-cnrm.fr/surfex/
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1069, 949]

  SFX_X001WG2   (949 × 1069 × 30 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × time
    Attributes:
     units                = m3/m3
     long_name            = Soil moisture layer 2 for patch 1
     _FillValue           = 9.96921e36
     institution          = MetCoOp
     model                = Variable from the External Surface model SURFEX
     comment              = Variable is named as in source code but with the prefix SFX_
     references           = https://www.umr-cnrm.fr/surfex/
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1069, 949]

  SFX_X002WG2   (949 × 1069 × 30 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × time
    Attributes:
     units                = m3/m3
     long_name            = Soil moisture layer 2 for patch 2
     _FillValue           = 9.96921e36
     institution          = MetCoOp
     model                = Variable from the External Surface model SURFEX
     comment              = Variable is named as in source code but with the prefix SFX_
     references           = https://www.umr-cnrm.fr/surfex/
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1069, 949]

  SFX_X001WSN_VEG1   (949 × 1069 × 30 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × time
    Attributes:
     units                = kg/m2
     standard_name        = liquid_water_content_of_surface_snow
     long_name            = Snow Water Equivalent layer 1 for patch 1 on nature tile
     _FillValue           = 9.96921e36
     institution          = MetCoOp
     model                = Variable from the External Surface model SURFEX
     comment              = Variable is named as in source code but with the prefix SFX_
     references           = https://www.umr-cnrm.fr/surfex/
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1069, 949]

  SFX_X002WSN_VEG1   (949 × 1069 × 30 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × time
    Attributes:
     units                = kg/m2
     standard_name        = liquid_water_content_of_surface_snow
     long_name            = Snow Water Equivalent layer 1 for patch 2 on nature tile
     _FillValue           = 9.96921e36
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1069, 949]

  SFX_X001RSN_VEG1   (949 × 1069 × 30 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × time
    Attributes:
     units                = kg/m3
     standard_name        = snow_density
     long_name            = Snow_density_layer_1
     _FillValue           = 9.96921e36
     institution          = MetCoOp
     model                = Variable from the External Surface model SURFEX
     comment              = Variable is named as in source code but with the prefix SFX_
     references           = https://www.umr-cnrm.fr/surfex/
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1069, 949]

  SFX_X002RSN_VEG1   (949 × 1069 × 30 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × time
    Attributes:
     units                = kg/m3
     standard_name        = snow_density
     long_name            = Snow_density_layer_1
     _FillValue           = 9.96921e36
     institution          = MetCoOp
     model                = Variable from the External Surface model SURFEX
     comment              = Variable is named as in source code but with the prefix SFX_
     references           = https://www.umr-cnrm.fr/surfex/
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1069, 949]

  SFX_WSN_T_ISBA   (949 × 1069 × 30 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × time
    Attributes:
     units                = kg/m2
     standard_name        = liquid_water_content_of_surface_snow
     long_name            = Snow Water Equivalent Total
     _FillValue           = 9.96921e36
     institution          = MetCoOp
     model                = Variable from the External Surface model SURFEX
     comment              = Variable is named as in source code but with the prefix SFX_
     references           = https://www.umr-cnrm.fr/surfex/
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1069, 949]

  SFX_DSN_T_ISBA   (949 × 1069 × 30 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × time
    Attributes:
     units                = m
     long_name            = Snow depth
     _FillValue           = 9.96921e36
     institution          = MetCoOp
     model                = Variable from the External Surface model SURFEX
     comment              = Variable is named as in source code but with the prefix SFX_
     references           = https://www.umr-cnrm.fr/surfex/
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1069, 949]

  SFX_Z0   (949 × 1069 × 30 × 62)
    Datatype:    Float32 (Float32)
    Dimensions:  x × y × ensemble_member × time
    Attributes:
     units                = m
     long_name            = Roughness length for momentum
     institution          = MetCoOp
     model                = Variable from the External Surface model SURFEX
     comment              = Variable is named as in source code but with the prefix SFX_
     references           = https://www.umr-cnrm.fr/surfex/
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1069, 949]

  SFX_Z0H   (949 × 1069 × 30 × 62)
    Datatype:    Float32 (Float32)
    Dimensions:  x × y × ensemble_member × time
    Attributes:
     units                = m
     long_name            = Roughness Length For Heat
     institution          = MetCoOp
     model                = Variable from the External Surface model SURFEX
     comment              = Variable is named as in source code but with the prefix SFX_
     references           = https://www.umr-cnrm.fr/surfex/
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1069, 949]

  cloud_base_altitude   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × surface × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Cloud base altitude
     standard_name        = cloud_base_altitude
     units                = m
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  visibility_in_air   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Visibility in air
     standard_name        = visibility_in_air
     units                = m
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

  specific_convective_available_potential_energy   (949 × 1069 × 30 × 1 × 62)
    Datatype:    Union{Missing, Float32} (Float32)
    Dimensions:  x × y × ensemble_member × height0 × time
    Attributes:
     _FillValue           = 9.96921e36
     long_name            = Convective Available Potential Energy (CAPE)
     standard_name        = specific_convective_available_potential_energy
     units                = J/kg
     grid_mapping         = projection_lambert
     coordinates          = longitude latitude
     _ChunkSizes          = Int32[1, 1, 1, 1069, 949]

Global attributes
  Conventions          = CF-1.6
  institution          = Norwegian Meteorological Institute, MET Norway
  creator_url          = met.no
  source               = MEPS 2.5km
  min_time             = 2024-02-19 12:00:00Z
  max_time             = 2024-02-19
  geospatial_lat_min   = 49.8
  geospatial_lat_max   = 75.2
  geospatial_lon_min   = -18.1
  geospatial_lon_max   = 54.2
  references           = unknown
  license              = https://www.met.no/en/free-meteorological-data/Licensing-and-crediting
  comment              = For more information, please visit https://github.com/metno/NWPdocs/wiki
  history              = 2024-02-17T02:27:33 creation by fimex
  DODS_EXTRA.Unlimited_Dimension = time
```


