
require File.join(File.dirname(__FILE__), '../lib/gilded_rose')

describe GildedRose do

  describe '#update_quality' do

    context 'Backstage passes to a TAFKAL80ETC concert' do
      it 'uses deadline item updater' do
        @item = Item.new('Backstage passes to a TAFKAL80ETC concert', 20, 10)
        gilded_rose = GildedRose.new([@item])
        gilded_rose.update_quality
        expect(gilded_rose.updater).to be_an_instance_of(DeadlineItemUpdater)
      end
    end

    context 'Aged Brie' do
      it 'uses deadline item updater' do
        @item = Item.new('Aged Brie', 20, 10)
        gilded_rose = GildedRose.new([@item])
        gilded_rose.update_quality
        expect(gilded_rose.updater).to be_an_instance_of(AgedItemUpdater)
      end
    end

    context 'Conjured hair shirt' do
      it 'uses deadline item updater' do
        @item = Item.new('Conjured hair shirt', 20, 10)
        gilded_rose = GildedRose.new([@item])
        gilded_rose.update_quality
        expect(gilded_rose.updater).to be_an_instance_of(ConjuredItemUpdater)
    end
    end

    context 'Sulfuras, Hand of Ragnaros' do
      it 'uses deadline item updater' do
        @item = Item.new('Sulfuras, Hand of Ragnaros', 20, 10)
        gilded_rose = GildedRose.new([@item])
        gilded_rose.update_quality
        expect(gilded_rose.updater).to be_an_instance_of(LegendaryItemUpdater)
      end
    end

    context 'Sulfuras, Hand of Ragnaros' do
      it 'uses normalitem updater' do
        @item = Item.new('Hair shirt', 20, 10)
        gilded_rose = GildedRose.new([@item])
        gilded_rose.update_quality
        expect(gilded_rose.updater).to be_an_instance_of(NormalItemUpdater)
      end
    end

  end

end
