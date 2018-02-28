class GildedRose

  attr_reader :items

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|

      case item.name
      when "Sulfuras, Hand of Ragnaros"
        next
      when "Aged Brie"
        increase_quality(item)
        increase_quality(item) if item.sell_in <= 0
      when "Backstage passes to a TAFKAL80ETC concert"
        increase_quality(item)
        increase_quality(item) if item.sell_in < 11
        increase_quality(item) if item.sell_in < 6
        item.quality = 0 if item.sell_in <= 0
      else
        decrease_quality(item)
        decrease_quality(item) if item.sell_in <= 0
      end

      decrease_sell_in(item)

    end
  end
end

def increase_quality(item)
  item.quality += 1 if item.quality < 50
end

def decrease_quality(item)
  item.quality -= 1 if item.quality > 0
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