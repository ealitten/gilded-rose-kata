class GildedRose

  attr_reader :items

  MAX_QUALITY = 50
  MIN_QUALITY = 0

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      case item.name
      when "Sulfuras, Hand of Ragnaros"
        next
      when "Aged Brie"
        if item.sell_in > 0
          increase_quality(item, 1)
        else
          increase_quality(item, 2)
        end
      when "Backstage passes to a TAFKAL80ETC concert"
        case item.sell_in
        when 11..Float::INFINITY then increase_quality(item, 1)
        when 6..10 then increase_quality(item, 2)
        when 1..5 then increase_quality(item, 3)
        else item.quality = 0
        end
      when /^[Cc]onjured\b\w*/
        if item.sell_in > 0
          decrease_quality(item, 2)
        else
          decrease_quality(item, 4)
        end
      else
        if item.sell_in > 0
          decrease_quality(item, 1)
        else
          decrease_quality(item, 2)
        end
      end
      decrease_sell_in(item)
    end
  end
end

def increase_quality(item, increment = 1)
    increment.times { item.quality += 1 if item.quality < MAX_QUALITY }
end

def decrease_quality(item, increment = 1)
    increment.times { item.quality -= 1 if item.quality > MIN_QUALITY }
end

def decrease_sell_in(item)
  item.sell_in -= 1
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end