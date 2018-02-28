
require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    context 'when item is gig ticket' do
      it 'changes sell_in by 1' do
        gr = start_with_item('Backstage passes to a TAFKAL80ETC concert')
        expect { gr.update_quality }.to change { gr.items.first.sell_in }.by -1
      end
      context 'and quality is lower than 50' do
        it 'increases quality by 1' do
          gr = start_with_item('Backstage passes to a TAFKAL80ETC concert', 20, 10)
          expect { gr.update_quality }.to change { gr.items.first.quality }.by +1
        end
      end
      context 'and quality is 50 or greater' do
        it "doesn't change quality" do
          gr = start_with_item('Backstage passes to a TAFKAL80ETC concert', 10, 50)
          expect { gr.update_quality }.not_to change { gr.items.first.quality }
        end
      end
    end

    context 'when item is aged brie' do
      it 'changes sell_in by 1' do
        gr = start_with_item('Aged Brie')
        expect { gr.update_quality }.to change { gr.items.first.sell_in }.by -1
      end
      context 'and quality is lower than 50' do
        it 'increases quality by 1' do
          gr = start_with_item('Aged Brie', 10, 10)
          expect { gr.update_quality }.to change { gr.items.first.quality }.by +1
        end
      end
      context 'and quality is 50 or greater' do
        it "doesn't change quality" do
          gr = start_with_item('Aged Brie', 0, 50)
          expect { gr.update_quality }.not_to change { gr.items.first.quality }
        end
      end
    end

    context 'when item is legendary item' do
      it "doesn't change quality" do
        gr = start_with_item('Sulfuras, Hand of Ragnaros')
        expect { gr.update_quality }.not_to change { gr.items.first.quality }
      end
      it "doesn't change sell_in" do
        gr = start_with_item('Sulfuras, Hand of Ragnaros')
        expect { gr.update_quality }.not_to change { gr.items.first.sell_in }
      end
    end

    context 'when item is anything else' do
      it 'changes sell_in by 1' do
        gr = start_with_item('Hair shirt', 5, 10)
        expect { gr.update_quality }.to change { gr.items.first.sell_in }.by -1
      end
      context 'and quality is greater than 0' do
        it 'decreases quality by 1' do
          gr = start_with_item('Hair shirt', 5, 10)
          expect { gr.update_quality }.to change { gr.items.first.quality }.by -1
        end
      end
      context 'and quality is 0' do
        it "doesn't change quality" do
          gr = start_with_item('Hair shirt', 0, 0)
          expect { gr.update_quality }.not_to change { gr.items.first.quality }
        end
      end
    end
  end
end

def start_with_item(name, sell_in = 1, quality = 0)
  items = [Item.new(name, sell_in, quality)]
  GildedRose.new(items)
end