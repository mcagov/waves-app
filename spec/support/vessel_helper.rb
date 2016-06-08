def random_hin
  prefix = ISO3166::Data.codes.sample
  suffix = rand(36**12).to_s(36).upcase

  "#{prefix}-#{suffix}"
end

def random_mmsi_number
  prefix = rand(232..235)
  suffix = rand.to_s[2..7]

  "#{prefix}#{suffix}"
end

def random_radio_call_sign
  prefix = (65 + rand(25)).chr
  suffix = rand.to_s[2..6]

  "#{prefix}#{suffix}"
end
