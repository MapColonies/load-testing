#general settings
jmeterBin=../bin
resultsDir=../test-results

#connection settings
host=10.28.11.125
port=80

#test settings
requestsFile=./xyz-params-5k.csv
layer=1000
version=1
users=5
userRequests=100
runTimeMin=60
publishDb=SFBA-v001
delayBetweenRequests=100 #ms

## test script stat do not modify ###
#preperations
runTimeSec=$(($runTimeMin * 60))
now=$(date +"%d-%m-%y-%T")
dir="${resultsDir}/xyz-csv/${now}"
mkdir -p ${dir}
#test
${jmeterBin}/jmeter -n -t ./xyz-timed.jmx -l ${dir}/xyz-res.jtl -JtargetHost=${host} -JtargetPort=${port} -Jusers=${users} -JrequestsPerUser=${userRequests} \
        -JrunTimeSec=${runTimeSec} -Jlayer=${layer} -JparamFile=${requestsFile} -Jversion=${version} -JpublishDb=${publishDb} -JdelayBetweemRequestsMs=${delayBetweenRequests}
#generate reports
${jmeterBin}/JMeterPluginsCMD.sh --generate-png ${dir}/xyz-test-rtot.png --generate-csv ${dir}/xyz-test-rtot.csv --input-jtl ${dir}/xyz-res.jtl --plugin-type ResponseTimesOverTime --width 800 --height 600
${jmeterBin}/JMeterPluginsCMD.sh --generate-csv ${dir}/xyz-test-agg.csv --input-jtl ${dir}/xyz-res.jtl --plugin-type AggregateReport
