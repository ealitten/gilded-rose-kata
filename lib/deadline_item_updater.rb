class DeadlineItemUpdater < ItemUpdater

  def update_quality
    case @item.sell_in
    when 11..Float::INFINITY then increase_quality(1)
    when 6..10 then increase_quality(2)
    when 1..5 then increase_quality(3)
    else @item.quality = 0
    end
  end

end