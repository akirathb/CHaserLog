require 'open-uri'
require 'json'

loc = "https://raw.githubusercontent.com/akirathb/CHaserLog/master/CH-20181108214143.log"
## proxy = ["http://host:port", "user","pass"]
f=open(loc, {:proxy_http_basic_authentication => proxy})
one = f.gets # 先頭1行読み飛ばす

one = f.gets
map1 = JSON.parse(one)["map"]
map1.each_with_index.each {|x,i|
  x.each_with_index.each {|v,j|
    puts "\"{\\\"i\\\":" + i.to_s + ",\\\"j\\\":"+ j.to_s  +  ",\\\"v\\\":"+ v.to_s + "}\""
    }
  }

f.each_line {|line|
 turn = JSON.parse(line)
  p turn["diff"]
  }

f.close
