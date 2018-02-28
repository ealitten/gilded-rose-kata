require './lib/item_updater'
require './lib/item'
describe ItemUpdater do

  describe '#increase_quality' do
    context 'when quality is at maximum quality (50)' do
      it "doesn't change quality" do
        @item = Item.new('Hair shirt', 10, 50)
        updater = ItemUpdater.new(@item)
        expect { updater.increase_quality }.not_to change { @item.quality }
      end
    end
    context 'when quality is below maximum quality (50)' do
      it "increases quality" do
        @item = Item.new('Hair shirt', 10, 10)
        updater = ItemUpdater.new(@item)
        expect { updater.increase_quality }.to change { @item.quality }.by 1
      end
    end
  end

  describe '#decrease_quality' do
    context 'when quality is at minimum quality (0)' do
      it "doesn't change quality" do
        @item = Item.new('Hair shirt', 10, 0)
        updater = ItemUpdater.new(@item)
        expect { updater.decrease_quality }.not_to change { @item.quality }
      end
    end
    context 'when quality is above minimum quality (0)' do
      it "decreases quality" do
        @item = Item.new('Hair shirt', 10, 10)
        updater = ItemUpdater.new(@item)
        expect { updater.decrease_quality }.to change { @item.quality }.by(-1)
      end
    end
  end



end