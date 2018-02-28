class ItemUpdater

  MAX_QUALITY = 50
  MIN_QUALITY = 0

  def initialize(item)
    @item = item
  end

  def increase_quality(increment = 1)
    increment.times { @item.quality += 1 if @item.quality < MAX_QUALITY }
  end

  def decrease_quality(increment = 1)
    increment.times { @item.quality -= 1 if @item.quality > MIN_QUALITY }
  end

  def decrease_sell_in
    @item.sell_in -= 1
  end

  def in_date?
    @item.sell_in > 0
  end

end