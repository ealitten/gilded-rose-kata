require_relative 'item'

class GildedRose
  attr_reader :items

  MAX_QUALITY = 50
  MIN_QUALITY = 0

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
      when 'Sulfuras, Hand of Ragnaros'
        next
      when 'Aged Brie'
        update_aged_brie(item)
      when 'Backstage passes to a TAFKAL80ETC concert'
        update_backstage_passes(item)
      when /^[Cc]onjured\b\w*/
        update_conjured_item(item)
      else
        update_normal_item(item)
      end
      decrease_sell_in(item)
    end
  end

  private

  def update_backstage_passes(item)
    case item.sell_in
    when 11..Float::INFINITY then increase_quality(item, 1)
    when 6..10 then increase_quality(item, 2)
    when 1..5 then increase_quality(item, 3)
    else item.quality = 0
    end
  end

  def update_aged_brie(item)
    if in_date?(item.sell_in)
      increase_quality(item, 1)
    else
      increase_quality(item, 2)
    end
  end

  def update_conjured_item(item)
    if in_date?(item.sell_in)
      decrease_quality(item, 2)
    else
      decrease_quality(item, 4)
    end
  end

  def update_normal_item(item)
    if in_date?(item.sell_in)
      decrease_quality(item, 1)
    else
      decrease_quality(item, 2)
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

  def in_date?(sell_in)
    sell_in > 0
  end
end
