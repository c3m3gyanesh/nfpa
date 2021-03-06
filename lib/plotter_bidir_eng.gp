#### Basic gnuplot related settings ####
# input_file is a gnuplot command line argument set by 
# $ gnuplot -e "input_file='Data.dat';pps_unit='K';bps_unit='G';tr1='tr2i';tr2='tr2i';" Data.gp 
INPUT_DATA=input_file
OUTPUT_BASENAME=INPUT_DATA[:strlen(INPUT_DATA)-5]."_"
PPS_UNIT=pps_unit
BPS_UNIT=bps_unit
TR1=tr1
TR2=tr2

set term postscript 
set termoption dashed

#this makes legend out of the diagram and gets these titles from the first line 
#of the datafile
#set key autotitle columnhead out   

#setting output style
set size 1.5,1.0
set terminal postscript eps noenhanced color 20 font "Verdana"

#set separator
set datafile separator ","

set xrange [64:1500]

#Setting the x and y axis's fonts
set xtics font ", 22"
set ytics font ", 22"

#Setting x and y axis's labels and their offset
set ylabel "Packet/sec [".PPS_UNIT."pps]" font ", 28"
set xlabel "Packet size [Byte]" font ", 28"


#Setting the legend to bottom-right with 5 length of the sample, with 4 vertical spacing and with 18 font-size
set key right top samplen 5 spacing 4 


#### Throughput packet/s ####
## SENT VS RECV ###
#Setting output
set output OUTPUT_BASENAME."sent_recv_".PPS_UNIT."pps_eng.eps"

#this actually puts out the results
p INPUT_DATA u 1:2:2:2:xtic(1) with yerrorlines pt 1 ps 3 lw 8 lt 1 lc rgb "#C9C9C9" title "Theoretical", \
  INPUT_DATA u 1:4:3:5:xtic(1) with yerrorlines pt 4 ps 2 lw 6 lt 1 dt 2 lc rgb "#FF8100" title "Sent-".TR1, \
  INPUT_DATA u 1:7:6:8:xtic(1) with yerrorlines pt 10 ps 3 lw 6 lt 1 dt 3 lc rgb "#008F37" title "Recv-".TR1, \
  INPUT_DATA u 1:22:21:23:xtic(1) with yerrorlines pt 12 ps 2 lw 6 lt 1 dt 4 lc rgb "#B500FF" title "Sent-".TR2, \
  INPUT_DATA u 1:25:24:26:xtic(1) with yerrorlines pt 8 ps 3 lw 6 lt 1 dt 5 lc rgb "#BDFF00" title "Recv-".TR2
  


### MISSED PACKETS ###
#Setting output
set output OUTPUT_BASENAME."miss_".PPS_UNIT."pps_eng.eps"
p INPUT_DATA u 1:10:9:11:xtic(1) with yerrorlines pt 2 ps 3 lw 6 lt 1 dt 4 lc rgb "#F90C38" title "Miss-".TR1, \
  INPUT_DATA u 1:28:27:29:xtic(1) with yerrorlines pt 3 ps 3 lw 6 lt 1 dt 4 lc rgb "#F90CB9" title "Miss-".TR2
  

#### Throughput Mbit/s #####
## SENT VS RECV ###
#Setting output
set key right top samplen 5 spacing 4

set output OUTPUT_BASENAME."sent_recv_".BPS_UNIT."bps_eng.eps"
set ylabel BPS_UNIT."bit/s" offset 1.5,0 font ", 28"

#this actually puts out the results
p INPUT_DATA u 1:13:12:14:xtic(1) with yerrorlines pt 4 ps 2 lw 6 lt 1 dt 2 lc rgb "#FF8100" title "Sent-".TR1, \
  INPUT_DATA u 1:16:15:17:xtic(1) with yerrorlines pt 10 ps 3 lw 6 lt 1 dt 3 lc rgb "#008F37" title "Recv-".TR1, \
  INPUT_DATA u 1:31:30:32:xtic(1) with yerrorlines pt 12 ps 2 lw 6 lt 1 dt 4 lc rgb "#B500FF" title "Sent-".TR2, \
  INPUT_DATA u 1:34:33:35:xtic(1) with yerrorlines pt 8 ps 3 lw 6 lt 1 dt 5 lc rgb "#BDFF00" title "Recv-".TR2


### DIFFERENCE BETWEEN SENT BPS AND RECV BPS
## SENT VS RECV ###
#Setting output
set output OUTPUT_BASENAME."diff_".BPS_UNIT."bps_eng.eps"
p INPUT_DATA u 1:19:18:20:xtic(1) with yerrorlines pt 2 ps 3 lw 6 lt 1 dt 4 lc rgb "#F90C38" title "Diff-".TR1, \
  INPUT_DATA u 1:37:36:38:xtic(1) with yerrorlines pt 3 ps 3 lw 6 lt 1 dt 4 lc rgb "#F90CB9" title "Diff-".TR2


