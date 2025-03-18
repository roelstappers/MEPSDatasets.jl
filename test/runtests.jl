
using MEPSDatasets, Dates 

dtg = DateTime(today())    
ds01 = ENSds(dtg,type="sfc", field="air_temperature_2m")           