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

def random_radio_call_sign(length = [6, 7].sample)
  rand(36**length).to_s(36).upcase
end
