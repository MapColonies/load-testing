
#general settings
jmeterBin=../bin
resultsDir=../test-results

#connection settings
host=10.28.11.95
port=8600
wmtsUrl="geoserver/gwc/service/wmts"

#global test settings
requestsFile=./wmts-params-5k.csv
imageFormat=image/png
layer=GS_Workspace:057286465010_01_assembly_201217062456_Pyramids
projection=EPSG:4326
version=1.0.0

#tests selection
runConfigurable=false
runTimed=true

#configurable and timed test settings
users=5
requestDelay=500 #ms

#configurable test settings
userRequests=100

#timed test settings
runTimeMin=60


### test script stat do not modify ###
#preperations
runTimeSec=$(($runTimeMin * 60))
now=$(date +"%d-%m-%y-%T")
dir="${resultsDir}/wmts_csv/${now}"
mkdir -p ${dir}
#test
${jmeterBin}/jmeter -n -t ./WMTS_CSV.jmx -l ${dir}/wmtscsv-res.jtl -JtargetHost=${host} -JtargetPort=${port} -Jusers=${users} -JrequestsPerUser=${userRequests} \
        -JtargetPath=${wmtsUrl} -JparamFile=${requestsFile} -JrunTimeSec=${runTimeSec} -JrunTimed=${runTimed} -JrunConfigurable=${runConfigurable} \
        -JimageFormat=${imageFormat} -Jlayer=${layer} -Jprojection=${projection} -Jversion=${version} -JrequestDelay=${requestDelay}
#generate reports
${jmeterBin}/JMeterPluginsCMD.sh --generate-png ${dir}/wmtscsv-test-rtot.png --generate-csv ${dir}/wmtscsv-test-rtot.csv --input-jtl ${dir}/wmtscsv-res.jtl --plugin-type ResponseTimesOverTime --width 800 --height 600
${jmeterBin}/JMeterPluginsCMD.sh --generate-csv ${dir}/wmtscsv-test-agg.csv --input-jtl ${dir}/wmtscsv-res.jtl --plugin-type AggregateReport
