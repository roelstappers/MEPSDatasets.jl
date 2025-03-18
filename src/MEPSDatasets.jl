module MEPSDatasets

using  Dates, NCDatasets
import Preferences: @load_preference

export ENSds, CTLds 


threddsurl="https://thredds.met.no/thredds/dodsC/meps25epsarchive/"

# const rooturl = @load_preference("rooturl",threddsurl)  # default to threddsurl

const rooturl = "/lustre/storeA/immutable/archive/projects/metproduction/MEPS/"

memberdict =Dict(
    "00" => "member_".*["02","09","12","00","01"],   # note it is important to keep this order mbr 00 and 01 are special
    "01" => "member_".*["03","04","07","10","13"],
    "02" => "member_".*["05","06","08","11","14"]
)
# /thredds/dodsC/meps25epsarchive/2025/02/02/03/member_12/meps_pl_60_20250202T03Z.nc

# Example https://thredds.met.no/thredds/dodsC/meps25epsarchive/2025/02/02/03/member_12/meps_pl_60_20250202T03Z.nc

"""
type:  
* pl  pressure level  
* sfc surface level
"""
function ENSds(dtg::Dates.AbstractTime;fchour=0,type="sfc") 
    urls = joinpath.(rooturl, 
        Dates.format(dtg,"yyyy/mm/dd/HH"),
        memberdict[lpad(Dates.Hour(dtg).value % 3,2,'0')],
        "meps_$(type)_$(lpad(fchour,2,'0'))_$(Dates.format(dtg,"yyyymmddTHH"))Z.nc"
    )
    # println(urls)

    ds = NCDataset(urls[[3,4,5,1,2]],aggdim="mbr", isnewdim=true)
    return view(ds,time=1,height0=1,height1=1,height2=1,height_above_msl=1) 
    
end 


   
end # module MEPSDatasets
