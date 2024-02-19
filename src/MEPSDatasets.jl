module MEPSDatasets

import Dates, NCDatasets 

export ENSds, CTLds 

rooturl="https://thredds.met.no/thredds/dodsC/meps25epsarchive/"

url(dtg) = joinpath(rooturl,Dates.format(dtg,"yyyy/mm/dd"))
yyyymmddTHH(dtg) = Dates.format(dtg,"yyyymmddTHH")

meps_lagged(dtg) = "meps_lagged_6_h_subset_2_5km_$(yyyymmddTHH(dtg))Z.nc"
meps_det(dtg) = "meps_det_sfc_$(yyyymmddTHH(dtg))Z.ncml"

mepsurl(dtg) = joinpath(url(dtg),meps_lagged(dtg))
ctlurl(dtg) = joinpath(url(dtg),meps_det(dtg))


enscheck_dtg(dtg) = Dates.DateTime(Dates.today()) - dtg < Dates.Day(31) || error("ENS  only available for last 30 days")


ENSds(dtg::AbstractArray) = NCDatasets.Dataset(mepsurl.(dtg),isnewdim=true, aggdim="forecast_reference_time", constvars=constvars)
CTLds(dtg::AbstractArray) = NCDatasets.Dataset(ctlurl.(dtg),isnewdim=true, aggdim="forecast_reference_time",constvars=constvars)

ENSds(dtg::Dates.AbstractTime) = NCDatasets.Dataset(mepsurl(dtg))
CTLds(dtg::Dates.AbstractTime) = NCDatasets.Dataset(ctlurl(dtg))

constvars = [
    "time"
    "ensemble_member"
    "height0"
    "height1"
    "height2"
    "height_above_msl"
    "hybrid"
    "isotherm_0C_level"
    "mean_sea_level"
    "pressure"
    "surface"
    "x"
    "y"
    "forecast_reference_time" 
]
    
end # module MEPSDatasets
