class PagesController < ApplicationController
  include HighVoltage::StaticPage

  layout :determine_layout

  private

  def determine_layout
    case params[:id]
    when "start"
      "public"
    else
      "private"
    end
  end
end
