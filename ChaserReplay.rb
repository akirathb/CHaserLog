# coding: utf-8
require 'minecraft-pi-ruby'
require 'open-uri'
require 'net/http'
require 'uri'
require 'json'

#loc = "https://raw.githubusercontent.com/akirathb/CHaserLog/master/CH-20181108173902.log"
#file = loc.split("/")[-1]

file = "CH-20181108173902.log"

mc = Minecraft.new
mc.say 'Start'
nx1 = 50
ny1 = 50
nx2 = -50
ny2 = -50
h0  = 0

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

position5 = Position.new(0,h2,ny2)

# mc.set_player_position(position5)
position6 = Position.new(0,1,0)

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
    return
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
  sleep(0.5)
end

File.open(file, mode = "r"){ |f|
  p f.gets  # # を読み飛ばす

  start =  JSON.parse(f.gets)
  map = start["map"]
  oy = (map.size) / 2
  ox = (map[0].size) /2

  i = -1 * ox
  j = -1 * oy

  # 最初のマップを書く

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
      i=i+1
    end
    i = -1 * ox
    j=j+1
  end

  @d = ""
  @s = ""
  
  f.each_line{|line|
#   a = gets.to_i
    @d = JSON.parse(line)["diff"]
    @d.each{|v| myputb2(v,ox,oy,mc)}
    @s = JSON.parse(line)["score"]
    print @s
  }
  mc.say @s
}
  
