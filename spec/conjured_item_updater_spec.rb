require './lib/conjured_item_updater'
require './lib/item'

describe ConjuredItemUpdater do

  describe '#update_quality' do
    context 'when item is within sell-by' do
      it 'decreases quality by 2' do
        @item = Item.new('Conjured hair shirt', 5, 10)
        updater =ConjuredItemUpdater.new(@item)
        expect { updater.update_quality }.to change { @item.quality }.by(-2)
      end
    end

    context 'when item is past sell-by' do
      it 'decreases quality by 4' do
        @item = Item.new('Conjured hair shirt', 0, 10)
        updater = ConjuredItemUpdater.new(@item)
        expect { updater.update_quality }.to change { @item.quality }.by(-4)
      end
    end
  end

end