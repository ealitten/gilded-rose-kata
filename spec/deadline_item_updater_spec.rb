require './lib/deadline_item_updater'
require './lib/item'

describe DeadlineItemUpdater do

  describe '#update_quality' do

    context 'when more than 10 days until concert' do
      it 'increases quality by 1' do
        @item = Item.new('Backstage passes to a TAFKAL80ETC concert', 20, 10)
        updater = DeadlineItemUpdater.new(@item)
        expect { updater.update_quality }.to change { @item.quality }.by 1
      end
    end

    context 'when between 10 and 6 days until concert' do
      it 'sell_in = 10, increases quality by 2' do
        @item = Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 10)
        updater = DeadlineItemUpdater.new(@item)
        expect { updater.update_quality }.to change { @item.quality }.by 2
      end
      it 'sell_in = 8, increases quality by 2' do
        @item = Item.new('Backstage passes to a TAFKAL80ETC concert', 8, 10)
        updater = DeadlineItemUpdater.new(@item)
        expect { updater.update_quality }.to change { @item.quality }.by 2
      end
      it 'sell_in = 6, increases quality by 2' do
        @item = Item.new('Backstage passes to a TAFKAL80ETC concert', 6, 10)
        updater = DeadlineItemUpdater.new(@item)
        expect { updater.update_quality }.to change { @item.quality }.by 2
      end
    end

    context 'and between 5 and 1 days until concert' do
      it 'sell_in = 5, increases quality by 3' do
        @item = Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 10)
        updater = DeadlineItemUpdater.new(@item)
        expect { updater.update_quality }.to change { @item.quality }.by 3
      end
      it 'sell_in = 1, increases quality by 3' do
        @item = Item.new('Backstage passes to a TAFKAL80ETC concert', 1, 10)
        updater = DeadlineItemUpdater.new(@item)
        expect { updater.update_quality }.to change { @item.quality }.by 3
      end
    end

    context 'and concert has passed (sell_in = 0)' do
      it 'sets value to zero' do
        @item = Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 10)
        updater = DeadlineItemUpdater.new(@item)
        expect { updater.update_quality }.to change { @item.quality }.by -10
      end
    end

  end
end