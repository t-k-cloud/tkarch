#!/usr/bin/python3
import os
import re
import time
import calendar
import re
import pycurl
import json
from io import BytesIO

def recent_birthday(path, N):
    lst_date = []

    # read birthday file into the array
    f = open(path ,"r")
    reg = re.compile('^([0-9]+)-([0-9]+)-([0-9]+):(.*)')
    for line in f:
        #print line
        match = reg.match(line)
        group = match.group(1,2,3,4)
        it = (int(group[0]), 
            int(group[1]), 
            int(group[2]), 
            group[3])
        lst_date.append(it) 
    f.close()

    # sort the list
    def compare(it):
        return it[2] + it[1] * 32

    # get a few future days(N days)
    i = 0
    t = time.localtime()
    today = (0, t.tm_mon, t.tm_mday)

    pri_date = []
    for it in lst_date:
        if (compare(it) >= compare(today) and
            compare(it) < compare(today) + N):
            pri_date.append(it)
        i += 1

    pri_date = sorted(pri_date, key=compare)
    #print pri_date
    
    ret_str = ''
    for it in pri_date:
        it_str = "%d-%d-%d(age=%d): %s" % (it[0], 
                it[1], it[2], t.tm_year - it[0],
                it[3])
        ret_str += it_str + "\n"
        
    return ret_str

def two_months_calendar():
    t = time.localtime()
    cal = calendar.month(t.tm_year, t.tm_mon)

    # set a cursor '##' to point to today
    today = t.tm_mday
    mark = '#' * len(str(today))
    cal = re.sub(r'([\n ])(' + str(today) + ')([\n ])', 
           '\g<1>' + mark + '\g<3>', cal)

    if t.tm_mon == 12:
        cal += calendar.month(t.tm_year + 1, 1)
    else:
        cal += calendar.month(t.tm_year, t.tm_mon + 1)
    return '[cmd]' + cal.replace(" ", "_") + '[/cmd]'

def temperature_str(Kelvin):
    Centigrade = round(Kelvin - 273.15, 1)
    Fahrenheit = round(Kelvin * (9/5) - 459.67, 1)
    return str(Fahrenheit) + '^F / ' + str(Centigrade) + '^C'

def get_weather():
    ret = ''
    c = pycurl.Curl()
    buf = BytesIO()
    # city id= Newark
    github_url = "http://api.openweathermap.org/data/2.5/forecast?id=5780993"
    # API key needed.
    github_url += '&APPID=6c8e2d090073f7d3d88084fdd841895a'
    c.setopt(pycurl.URL, github_url)
    c.setopt(pycurl.WRITEFUNCTION, buf.write)
    c.perform()
    c.close()
    parsed_json = json.loads(buf.getvalue().decode('utf-8'));
    # print(parsed_json)
    list_weather = parsed_json['list']
    for item in list_weather:
        ret += str(item['dt_txt']) + "\t" + \
               temperature_str(item['main']['temp']) + ", " + \
               str(item['weather'][0]['description']) + "\n"
    return '[code]' + ret + '[/code]'

def main():
    f1 = open("/home/tk/Desktop/todo", "r")
    todo = f1.read()

    bir = recent_birthday("/home/tk/tksync/incr/collect/.private/birthday", 30)
    cal = two_months_calendar()
    weather = get_weather()

    print( "<h1>TODO </h1> \n" + todo + "\n" +
           "<h1>CALENDAR </h1> \n" + cal + "\n" + 
           "<h1>WEATHER </h1> \n" + weather + "\n" + 
           "<h1>BIRTHDAY </h1>\n" + bir)

main()
