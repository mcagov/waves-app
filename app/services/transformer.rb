class Transformer
  class << self
    def upcase_params(input_params = {})
      input_params.each_pair do |k, v|
        { k => k.to_s.include?("email") ? v : v.upcase! }
      end
    end
  end
end
