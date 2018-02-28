class NormalItemUpdater < ItemUpdater

  def update_quality
    if in_date?
      decrease_quality(1)
    else
      decrease_quality(2)
    end
  end

end