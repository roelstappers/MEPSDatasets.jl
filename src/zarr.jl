

using Zarr

function nc2zarr(ds,zarrpath) 
    
    
    z = Zarr.zcreate(Float32,100,100,30, path = zarrpath, chuncks=(100,100,1))
    z .= ds["temperature"][:,:,:]






end 