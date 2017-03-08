class Submission::Vessel < WavesUtilities::Vessel
  def port_name
    WavesUtilities::Port.new(port_code).name if port_code
  end

  def pln
    "#{port_code}#{port_no}"
  end
end
