#!/usr/bin/python

# temperature getter thing from RPi 

import glob
import sys
import os 


list=glob.glob("/sys/bus/w1/devices/28*")	# List of sensors
tempdb="/home/dave/temp.out"			# RRD output file


#Get the temp from the sensor (sensor as input)
def gettemp(sens):
#	print (sens)
	tfile = open(sens+"/w1_slave")
	text = tfile.read()

	# split sensor output into single lines, take the 2nd line only
	sgl=text.split("\n")[1]
	# split the single line into columns delimited by space, take only the 10th
	num=sgl.split(" ")[9]
	# drop the "t=" and convert to float
	out=float (num[2:])
	# convert to decimal 
	out=out / 1000
	# shit it out to RRD
	oscall = "/usr/bin/rrdtool update /srv/http/RRD/" + str(sens[20:]) + ".rrd N:" + str(out)
	os.system(oscall)
	# call rrd to graph
	graphcall = "/home/dave/RPi_Temp/graph" + sens[20:] + ".sh"
#	print (graphcall)
	os.system(graphcall)
	# also dump to a file	
#	writetemp(sens,out)

	# close the sensor file
	tfile.close()


def writetemp(sensor,outtemp):
	wfile = open(tempdb,'a')
	outtemp=str(outtemp)
	wfile.write(sensor+ " ") 
	wfile.write(outtemp+"\n")	
	wfile.close()







#########e
#re 4  main  #
##########

# 	loop through all sensors and run gettemp on each one
for x in list:
	gettemp(x)






