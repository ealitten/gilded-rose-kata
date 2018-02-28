require_relative 'item_updater'

class ConjuredItemUpdater < ItemUpdater

  def update_quality
    if in_date?
      decrease_quality(2)
    else
      decrease_quality(4)
    end
  end

end