module BaseEncoders
  BASE_62_CHARACTERS = (('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a).join()
  class Base62
    def extract_valid_base_characters(value = "")
      value.to_s[/([0-9a-zA-Z]+)/]
    end

    def encode_to_base(num = 0, base = 62)
      # In case num is zero
      return BASE_62_CHARACTERS[0] if num == 0
      # Otherwise convert database
      result = ""
      while num != 0
        mod = num % base
        result.prepend(BASE_62_CHARACTERS[mod], "")
        num = (num / base).floor
      end
      result
    end


    def decode_from_base(value = 0, base = 62)
      base_10_number_result = 0
      # Position number for the id decoded
      digit = 0
      # Convert value to str and iterate using
      # all the characters
      value.to_s.reverse.each_char do |character|
        value_position = BASE_62_CHARACTERS.index(character)
        base_10_number_result += (base ** digit) * value_position
        digit += 1
      end
      base_10_number_result
    end
  end
end