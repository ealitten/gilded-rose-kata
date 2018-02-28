
require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    context 'when item is backstage passes' do
      it 'changes sell_in by 1' do
        gr = start_with_item('Backstage passes to a TAFKAL80ETC concert')
        expect { gr.update_quality }.to change { gr.items.first.sell_in }.by -1
      end
      context 'and quality is lower than 50' do
        context 'and more than 10 days until concert' do
          it 'increases quality by 1' do
            gr = start_with_item('Backstage passes to a TAFKAL80ETC concert', 20, 10)
            expect { gr.update_quality }.to change { gr.items.first.quality }.by +1
          end
        end
        context 'and between 10 and 6 days until concert' do
          it 'sell_in = 10, increases quality by 2' do
            gr = start_with_item('Backstage passes to a TAFKAL80ETC concert', 10, 10)
            expect { gr.update_quality }.to change { gr.items.first.quality }.by +2
          end
          it 'sell_in = 8, increases quality by 2' do
            gr = start_with_item('Backstage passes to a TAFKAL80ETC concert', 8, 10)
            expect { gr.update_quality }.to change { gr.items.first.quality }.by +2
          end
          it 'sell_in = 6, increases quality by 2' do
            gr = start_with_item('Backstage passes to a TAFKAL80ETC concert', 6, 10)
            expect { gr.update_quality }.to change { gr.items.first.quality }.by +2
          end
          it 'quality = 49, only increases quality by 1 (caps at 50)' do
            gr = start_with_item('Backstage passes to a TAFKAL80ETC concert', 6, 49)
            expect { gr.update_quality }.to change { gr.items.first.quality }.by +1
          end
        end
        context 'and between 5 and 1 days until concert' do
          it 'sell_in = 5, increases quality by 3' do
            gr = start_with_item('Backstage passes to a TAFKAL80ETC concert', 5, 10)
            expect { gr.update_quality }.to change { gr.items.first.quality }.by +3
          end
          it 'sell_in = 1, increases quality by 3' do
            gr = start_with_item('Backstage passes to a TAFKAL80ETC concert', 1, 10)
            expect { gr.update_quality }.to change { gr.items.first.quality }.by +3
          end
          it 'quality = 49, only increases quality by 1 (caps at 50)' do
            gr = start_with_item('Backstage passes to a TAFKAL80ETC concert', 2, 49)
            expect { gr.update_quality }.to change { gr.items.first.quality }.by +1
          end
        end
        context 'and concert has passed (sell_in = 0)' do
          it 'sets value to zero' do
            gr = start_with_item('Backstage passes to a TAFKAL80ETC concert', 0, 10)
            gr.update_quality
            expect(gr.items.first.quality).to eq 0
          end
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
        gr = start_with_item('Hair shirt')
        expect { gr.update_quality }.to change { gr.items.first.sell_in }.by -1
      end
      context 'and quality is greater than 0' do
        context 'and item is within sell-by' do
          it 'decreases quality by 1' do
            gr = start_with_item('Hair shirt', 5, 10)
            expect { gr.update_quality }.to change { gr.items.first.quality }.by -1
          end
        end
        context 'and item is past sell-by' do
          it 'decreases quality by 2' do
            gr = start_with_item('Hair shirt', 0, 10)
            expect { gr.update_quality }.to change { gr.items.first.quality }.by -2
          end
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