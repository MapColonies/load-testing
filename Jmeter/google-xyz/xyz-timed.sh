#general settings
jmeterBin=../bin
resultsDir=../test-results

#connection settings
host=10.28.11.95
port=8600

#test settings
layer=1000
version=3
users=100
userRequests=100
runTimeMin=1
publishDb=imagery_test
delayBetweenRequests=100 #ms

### test script do not modify ###

runTime=$((duration*60))
echo "starting xyz test with ${users} users for ${runTime} seconds (${duration} minutes)"
rm ../test-results/$users/$duration/xyz-res.jtl
../bin/jmeter -n -t ./xyz-timed.jmx -l ../test-results/$users/$duration/xyz-res.jtl -JtargetHost=$target -Jusers=$users -JdelayBetweemRequestsMs=$delayBetweenRequests -JrequstsPerUser=$requstsPerUser -JrunTimeSec=$runTime -Jlayer=$layer -JpublishDb=$publishDb -Jversion=$version
../bin/JMeterPluginsCMD.sh --generate-png ../test-results/$users/$duration/xyz-test-rtot.png --generate-csv ../test-results/$users/$duration/xyz-test-rtot.csv --input-jtl ../test-results/$users/$duration/xyz-res.jtl --plugin-type ResponseTimesOverTime --width 800 --height 600
../bin/JMeterPluginsCMD.sh --generate-csv ../test-results/$users/$duration/xyz-test.csv --input-jtl ../test-results/$users/$duration/xyz-res.jtl --plugin-type AggregateReport


## test script stat do not modify ###
#preperations
runTimeSec=$(($runTimeMin * 60))
now=$(date +"%d-%m-%y-%T")
dir="${resultsDir}/xyz/${now}"
mkdir -p ${dir}
#test
${jmeterBin}/jmeter -n -t ./xyz.jmx -l ${dir}/xyz-res.jtl -JtargetHost=${host} -JtargetPort=${port} -Jusers=${users} -JrequestsPerUser=${userRequests} \
        -JrunTimeSec=${runTimeSec} -Jlayer=${layer} -Jversion=${version} -JpublishDb=${publishDb} -JdelayBetweemRequestsMs=${delayBetweenRequests}
#generate reports
${jmeterBin}/JMeterPluginsCMD.sh --generate-png ${dir}/wms-test-rtot.png --generate-csv ${dir}/wms-test-rtot.csv --input-jtl ${dir}/wms-res.jtl --plugin-type ResponseTimesOverTime --width 800 --height 600
${jmeterBin}/JMeterPluginsCMD.sh --generate-csv ${dir}/wms-test-agg.csv --input-jtl ${dir}/wms-res.jtl --plugin-type AggregateReport
