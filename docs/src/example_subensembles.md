



```julia
using MEPSDatasets, Dates, NCDatasets 
using Statistics  
using GLMakie

dtg1 = DateTime(2025,03,10,10,0); fchour1 = 2
dtg2 = DateTime(2025,03,10,11,0); fchour2 = 1
dtg3 = DateTime(2025,03,10,12,0); fchour3 = 0


ds1 = ENSds(dtg1,type="sfc",fchour=fchour1)
ds2 = ENSds(dtg2,type="sfc",fchour=fchour2)
ds3 = ENSds(dtg3,type="sfc",fchour=fchour3)

var = "surface_air_pressure"
 var = "air_temperature_2m"
var = "x_wind_10m"
var =  "air_pressure_at_sea_level"
flds1 = nomissing(ds1[var][:,:,:])
flds2 = nomissing(ds2[var][:,:,:])
flds3 = nomissing(ds3[var][:,:,:])

meanfld1 = mean(flds1,dims=3)[:,:,1]
meanfld2 = mean(flds2,dims=3)[:,:,1]
meanfld3 = mean(flds3,dims=3)[:,:,1]

stdfld1  = std(flds1, dims=3)[:,:,1]
stdfld2  = std(flds2, dims=3)[:,:,1]
stdfld3  = std(flds3, dims=3)[:,:,1]

colorrange = (-1,1)
fig = Figure()
ax11  = Axis(fig[1,1], title="$dtg1 + $fchour1" )
hmstd1 = heatmap!(ax11,stdfld1,colormap=:jet) # ,colorrange=colorrange)
hidedecorations!(ax11)
Colorbar(fig[1,0], hmstd1)
ax12  = Axis(fig[1,2],title="$dtg2 + $fchour2") # ,colorrange=colorrange)
hmstd2 = heatmap!(ax12,stdfld2,colormap=:jet)
ax21  = Axis(fig[2,1],title="$dtg3 + $fchour3") # ,colorrange=colorrange)
hmstd3 = heatmap!(ax21,stdfld3,colormap=:jet)

hidedecorations!(ax11)
hidedecorations!(ax12)
hidedecorations!(ax21)

#Colorbar(fig[1,3], hmmean)
#hidedecorations!(ax2)
#Label(fig[0,:],"$dtg + $fchour")

fig




```