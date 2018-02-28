require './lib/normal_item_updater'
require './lib/item'

describe NormalItemUpdater do

  describe '#update_quality' do
    context 'when item is within sell-by' do
      it 'decreases quality by 1' do
        @item = Item.new('Hair shirt', 5, 10)
        updater = NormalItemUpdater.new(@item)
        expect { updater.update_quality }.to change { @item.quality }.by(-1)
      end
    end

    context 'when item is past sell-by' do
      it 'decreases quality by 2' do
        @item = Item.new('Hair shirt', 0, 10)
        updater = NormalItemUpdater.new(@item)
        expect { updater.update_quality }.to change { @item.quality }.by(-2)
      end
    end
  end

end