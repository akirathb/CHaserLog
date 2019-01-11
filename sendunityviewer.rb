require 'open-uri'
require 'json'

loc = "https://raw.githubusercontent.com/akirathb/CHaserLog/master/CH-20181108214143.log"

## proxy = ["http://157.114.16.93:8080", "akira",""]
## file = OpenURI.open_uri(loc, {:proxy_http_basic_authentication => proxy})

## file = OpenURI.open_uri(loc) # Porxyなし
file = loc.split("/")[-1]    # カレントディレクトリにダウンロードしたログファイル

File.open(file, mode = "r") {|f| 

  one = f.gets # 先頭1行読み飛ばす

  one = f.gets
  map1 = JSON.parse(one)["map"]
  
  map1.each_with_index.each {|x,i|
    x.each_with_index.each {|v,j|
      json = "\"{\\\"i\\\":" + i.to_s + ", \\\"j\\\": "+ j.to_s  +  ", \\\"v\\\":"+ v.to_s + "}\""
      puts json
      }
    }

  f.each_line {|line|
    turn = JSON.parse(line)
    p turn["diff"]
    }
  }
