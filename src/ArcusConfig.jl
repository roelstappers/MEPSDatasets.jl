
using AWS 
using AWSS3

@service S3
struct ArcusConfig <: AbstractAWSConfig
    endpoint::String
    region::String
    creds
end

# default constructor 
ArcusConfig() = ArcusConfig("https://arcus-s3.nsc.liu.se","us-east-1",AWSCredentials()) 

AWS.region(c::ArcusConfig) = c.region
AWS.credentials(c::ArcusConfig) = c.creds
# AWS.check_credentials(c::SimpleCredentials) = c 

function AWS.generate_service_url(aws::ArcusConfig, service::String, resource::String)
    service == "s3" || throw(ArgumentError("Can only handle s3 requests"))
    return string(aws.endpoint, resource)
end


# Example 
arcus = ArcusConfig()
# AWS.global_aws_config(arcus)  

p = S3Path("s3://ECMWF_BD/",config=arcus)