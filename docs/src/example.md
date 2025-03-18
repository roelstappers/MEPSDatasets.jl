



```julia

using MEPSDatasets, Dates, NCDatasets 
using Statistics  
using GLMakie

dtg = DateTime(2025,03,10,6,0); fchour = 6
dtg = DateTime(2025,03,10,9,0); fchour = 3
dtg = DateTime(2025,03,10,12,0); fchour = 1


ds = ENSds(dtg,type="sfc",fchour=fchour)

var = "surface_air_pressure"
# var = "air_temperature_2m"
flds = nomissing(ds[var][:,:,:])

meanfld = mean(flds,dims=3)[:,:,1]


stdfld  = std(flds, dims=3)[:,:,1]


fig = Figure()
ax1  = Axis(fig[1,1], title="Standard deviation $var" )
hmstd = heatmap!(ax1,(stdfld),colormap=:jet)
hidedecorations!(ax1)
Colorbar(fig[1,0], hmstd)
ax2  = Axis(fig[1,2],title="Mean $var")
hmmean = heatmap!(ax2,meanfld,colormap=:jet)
Colorbar(fig[1,3], hmmean)
hidedecorations!(ax2)
Label(fig[0,:],"$dtg + $fchour")

fig



```