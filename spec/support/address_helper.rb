def random_postcode
  [
    [*("A".."Z")].sample(2).join,
    rand(10).to_s,
    " ",
    rand(10).to_s,
    [*("A".."Z")].sample(2).join,
  ].join
end
