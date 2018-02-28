require_relative 'item'
require_relative 'item_updater'
require_relative 'normal_item_updater'
require_relative 'aged_item_updater'
require_relative 'legendary_item_updater'
require_relative 'deadline_item_updater'
require_relative 'conjured_item_updater'

class GildedRose
  attr_reader :items
  attr_reader :updater

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
      when 'Sulfuras, Hand of Ragnaros'
        @updater = LegendaryItemUpdater.new(item)
      when 'Aged Brie'
        @updater = AgedItemUpdater.new(item)
      when 'Backstage passes to a TAFKAL80ETC concert'
        @updater = DeadlineItemUpdater.new(item)
      when /^[Cc]onjured\b\w*/
        @updater = ConjuredItemUpdater.new(item)
      else
        @updater = NormalItemUpdater.new(item)
      end
      @updater.update_quality
      @updater.decrease_sell_in
    end
  end
end
