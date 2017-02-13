module ShareholdingHelper
  def share_allocation_message(shareholding)
    if shareholding.status == :incomplete
      "<small>(#{pluralize(shareholding.unallocated, 'shares')} "\
      "un-allocated)</small>"
    elsif shareholding.status == :excessive
      "<small class='red'>(Invalid share allocation)</small>"
    else
      ""
    end
  end
end
