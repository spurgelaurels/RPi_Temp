#!/bin/bash
RRDPATH="/srv/http/RRD"
RAWCOLOUR="#FF0000"
TRENDCOLOUR="#0000FF"

####    28-000004f803b9
#hour
rrdtool graph $RRDPATH/nursery-hour.png --start -1h \
DEF:temp=$RRDPATH/28-000004f803b9.rrd:temp:AVERAGE \
CDEF:trend=temp,1800,TREND \
LINE2:temp$RAWCOLOUR:"Hourly temperature" \
LINE1:trend$TRENDCOLOUR:"30 min average"

#day
rrdtool graph $RRDPATH/nursery-day.png --start -1d \
DEF:temp=$RRDPATH/28-000004f803b9.rrd:temp:AVERAGE \
CDEF:trend=temp,21600,TREND \
LINE2:temp$RAWCOLOUR:"Daily temperature" \
LINE1:trend$TRENDCOLOUR:"6h average"

#week
rrdtool graph $RRDPATH/nursery-week.png --start -1w \
DEF:temp=$RRDPATH/28-000004f803b9.rrd:temp:AVERAGE \
LINE2:temp$RAWCOLOUR:"Weekly temperature" \

#month
rrdtool graph $RRDPATH/nursery-month.png --start -1m \
DEF:temp=$RRDPATH/28-000004f803b9.rrd:temp:AVERAGE \
LINE1:temp$RAWCOLOUR:"Monthly temperature" \

#year
rrdtool graph $RRDPATH/nursery-year.png --start -1y \
DEF:temp=$RRDPATH/28-000004f803b9.rrd:temp:AVERAGE \
LINE1:temp$RAWCOLOUR:"Yearly temperature" \

