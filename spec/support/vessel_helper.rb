def random_alphanumeric_string(length)
  ([*("0".."9"), *("A".."Z")]).sample(length).join
end

def random_hin
  prefix = ISO3166::Data.codes.sample
  suffix = random_alphanumeric_string(12)

  "#{prefix}-#{suffix}"
end

def random_mmsi_number
  prefix = rand(232..235)
  suffix = rand.to_s[2..7]

  "#{prefix}#{suffix}"
end

def random_radio_call_sign(length = [6, 7].sample)
  random_alphanumeric_string(length)
end
