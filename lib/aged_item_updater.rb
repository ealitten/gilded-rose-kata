require_relative 'item_updater'

class AgedItemUpdater < ItemUpdater

  def update_quality
    if in_date?
      increase_quality(1)
    else
      increase_quality(2)
    end
  end

end