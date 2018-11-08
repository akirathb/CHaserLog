# coding: utf-8
require 'minecraft-pi-ruby'
require 'open-uri'
require 'json'

loc = "https://raw.githubusercontent.com/akirathb/CHaserLog/master/CH-20181108214143.log"
#file = OpenURI.open_uri(loc) # github からログファイルを直接読む

file = loc.split("/")[-1] # カレントディレクトリにダウンロードしたログファイル

mc = Minecraft.new
mc.say 'Start'

# 整地
nx1 = 50  
ny1 = 50  
nx2 = -50
ny2 = -50
h0  = 0
ph  = 10 # プレイヤーの高さ マップ読み取り後に使う

position1 = Position.new(nx1,h0,ny1)
position2 = Position.new(nx2,h0,ny2)
 
mc.make_cuboid(position1, position2, Block::GRASS)
sleep 1

h1  = h0 + 1
h2  = h1 + 10

position3 = Position.new(nx1,h1,ny1)
position4 = Position.new(nx2,h2,ny2)
  
mc.make_cuboid(position3, position4, Block::AIR)
sleep(1)
# mc.say 'Clear'

def myputb(x,y,b,ox,oy,obj)
  if b == 2
    obj.set_block(x-ox,1,y-oy, Block::STONE)
  elsif b == 0
    obj.set_block(x-ox,1,y-oy, Block::AIR)
  elsif b == 3
    obj.set_block(x-ox,1,y-oy, Block::MELON)
  elsif b == 4
    obj.set_block(x-ox,1,y-oy, Block::WOOL,3)
  elsif b == 5
    obj.set_block(x-ox,1,y-oy, Block::WOOL,6)
  else
  end
  sleep(0.5)
end

def myputb2(ar,ox,oy,obj)

  if ar == [] || ar.nil?
    return []
  end

  x = ar[0]
  y = ar[1]
  b = ar[2]

  if b == 2
    obj.set_block(x-ox,1,y-oy, Block::STONE)
  elsif b == 0
    obj.set_block(x-ox,1,y-oy, Block::AIR)
  elsif b == 3
    obj.set_block(x-ox,1,y-oy, Block::MELON)
  elsif b == 4
    obj.set_block(x-ox,1,y-oy, Block::WOOL,3)
  elsif b == 5
    obj.set_block(x-ox,1,y-oy, Block::WOOL,6)
  else
  end
  sleep(0.2)
end

File.open(file, mode = "r"){ |f|
  p f.gets  # 先頭行# を読み飛ばす

  start =  JSON.parse(f.gets)
  map = start["map"]
  oy = (map.size) / 2
  ox = (map[0].size) /2

  # Player を高みの見物に
  position5 = Position.new(0,1,oy+2)
  position6 = Position.new(0,ph,oy+2)
  position7 = Position.new(0,ph,oy+2)

  mc.make_cuboid(position5, position6, Block::GLASS)
  mc.set_player_position(position7)

  # 最初のマップを書く
  i = -1 * ox
  j = -1 * oy

  map.each do |col|
    col.each do |row|
      if row == 2
        mc.set_block(i,1,j, Block::STONE)
      elsif row == 0
        mc.set_block(i,1,j, Block::AIR)
      elsif row == 3
        mc.set_block(i,1,j, Block::MELON)
      elsif row == 4
        mc.set_block(i,1,j, Block::WOOL,3)
      elsif row == 5
        mc.set_block(i,1,j, Block::WOOL,6)
      else
      end
      i= i + 1
    end
    i = -1 * ox
    j = j + 1
  end

  d = ""
  f.each_line{|line|
    #  a = gets.to_i
    
    d = JSON.parse(line)
    d["diff"].each{|v| myputb2(v,ox,oy,mc)}
    print d["score"]
  }
  mc.say d["code"]
}
