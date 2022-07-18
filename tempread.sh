#!/bin/bash 
hostip="192.168.1.10"



get_sysctl_temp () {
    COUNTER=0
    while [  $COUNTER -lt 4 ]; do
        sysctl -a | grep temper > tempdatafile
    
        chelsiotemp=`cat tempdatafile | grep "dev.t6nex.0" |  awk -F':' '{print $2}' | grep -o '[0-9]\+'`
        cpu0temp=`cat tempdatafile | grep "dev.cpu.0.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu1temp=`cat tempdatafile | grep "dev.cpu.1.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu2temp=`cat tempdatafile | grep "dev.cpu.2.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu3temp=`cat tempdatafile | grep "dev.cpu.3.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu4temp=`cat tempdatafile | grep "dev.cpu.4.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu5temp=`cat tempdatafile | grep "dev.cpu.5.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu6temp=`cat tempdatafile | grep "dev.cpu.6.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu7temp=`cat tempdatafile | grep "dev.cpu.7.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu8temp=`cat tempdatafile | grep "dev.cpu.8.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu9temp=`cat tempdatafile | grep "dev.cpu.9.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu10temp=`cat tempdatafile | grep "dev.cpu.10.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu11temp=`cat tempdatafile | grep "dev.cpu.11.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu12temp=`cat tempdatafile | grep "dev.cpu.12.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu13temp=`cat tempdatafile | grep "dev.cpu.13.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu14temp=`cat tempdatafile | grep "dev.cpu.14.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu15temp=`cat tempdatafile | grep "dev.cpu.15.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu16temp=`cat tempdatafile | grep "dev.cpu.16.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu17temp=`cat tempdatafile | grep "dev.cpu.17.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu18temp=`cat tempdatafile | grep "dev.cpu.18.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu19temp=`cat tempdatafile | grep "dev.cpu.19.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu20temp=`cat tempdatafile | grep "dev.cpu.20.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu21temp=`cat tempdatafile | grep "dev.cpu.21.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu22temp=`cat tempdatafile | grep "dev.cpu.22.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu23temp=`cat tempdatafile | grep "dev.cpu.23.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu24temp=`cat tempdatafile | grep "dev.cpu.24.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu25temp=`cat tempdatafile | grep "dev.cpu.25.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`
        cpu26temp=`cat tempdatafile | grep "dev.cpu.26.temp" | awk -F':' '{print $2}' | grep -o '[0-9]\+.[0-9\+]' | cut -c 1-2`  
        rm tempdatafile 
   
        if [[ $chelsiotemp -le 0 || $cpu0temp -le 0 ]]; 
        	then
                echo "Retry getting data - received some invalid data from the read"
            else
                #We got good data - exit this loop
                COUNTER=10
        fi
        let COUNTER=COUNTER+1 
    done
    
    
 write_data () {
    #Write the data to the database
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=chelsiotemp value=$chelsiotemp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu0temp value=$cpu0temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu1temp value=$cpu1temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu2temp value=$cpu2temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu3temp value=$cpu3temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu4temp value=$cpu4temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu5temp value=$cpu5temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu6temp value=$cpu6temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu7temp value=$cpu7temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu8temp value=$cpu8temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu9temp value=$cpu9temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu10temp value=$cpu10temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu11temp value=$cpu1temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu12temp value=$cpu12temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu13temp value=$cpu13temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu14temp value=$cpu14temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu15temp value=$cpu15temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu16temp value=$cpu16temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu17temp value=$cpu17temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu18temp value=$cpu18temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu19temp value=$cpu19temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu20temp value=$cpu20temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu21temp value=$cpu21temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu22temp value=$cpu22temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu23temp value=$cpu23temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu24temp value=$cpu24temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu25temp value=$cpu25temp"
    curl -i -XPOST 'http://localhost:8086/write?db=temp' --data-binary "health_data,host=$hostip,sensor=cpu26temp value=$cpu26temp"
}   
    
    
while :
do
    #Sleep between readings
    sleep "$sleeptime"
    
    get_sysctl_temp
    
    if [[ $chelsiotemp -le 0 || $cpu0temp -le 0 ]];
    	then
            echo "Skip this datapoint - something went wrong with the read"
            
        else
            write_data
    fi
done
