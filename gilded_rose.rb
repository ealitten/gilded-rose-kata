class GildedRose

  attr_reader :items

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      next if item.name == "Sulfuras, Hand of Ragnaros"
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        decrease_quality(item)
      else
        increase_quality(item)
        if item.name == "Backstage passes to a TAFKAL80ETC concert"
          if item.sell_in < 11
              increase_quality(item)
          end
          if item.sell_in < 6
              increase_quality(item)
          end
        end
      end
      decrease_sell_in(item)
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            decrease_quality(item)
          else
            item.quality = 0
          end
        else
          increase_quality(item)
        end
      end
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