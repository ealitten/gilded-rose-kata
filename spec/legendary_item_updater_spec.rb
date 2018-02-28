require './lib/legendary_item_updater'
require './lib/item'

describe LegendaryItemUpdater do

  describe '#update_quality' do
    it 'does nothing' do
      @item = Item.new('Sulfuras, Hand of Ragnaros', 5, 10)
      updater = LegendaryItemUpdater.new(@item)
      expect { updater.update_quality }.not_to change { @item.quality }
    end
  end

  describe '#decrease_sell_in' do
  it 'does nothing' do
    @item = Item.new('Sulfuras, Hand of Ragnaros', 5, 10)
    updater = LegendaryItemUpdater.new(@item)
    expect { updater.decrease_sell_in }.not_to change { @item.sell_in }
  end
end

end