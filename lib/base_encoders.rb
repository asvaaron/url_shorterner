module BaseEncoders
  # Base62 Encoder
  class Base62
    # Define all the possible BASE62 Characters
    # from:0-9, a-z and A-Z
    # join hole array into unique string
    BASE_62_CHARACTERS = (('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a).join

    def extract_valid_base_characters(value = "")
      # User REGREX to remove not expected characters
      value.to_s[/([0-9a-zA-Z]+)/]
    end

    def encode_to_base(num = 0, base = 62)
      # In case num is zero
      return BASE_62_CHARACTERS[0] if num == 0
      # Otherwise convert database
      result = ""
      while num != 0
        result.prepend(BASE_62_CHARACTERS[num % base], "")
        num /= base
      end
      result
    end


    def decode_from_base(value_62_base = 0, base = 62)
      base_10_number_result = 0
      # Position number for the id decoded
      iterator_digit_pos = 0
      # Convert value to string and iterate using
      # all the characters
      value_62_base.to_s.reverse.each_char do |character|
        # Obtain BASE62 residue
        residue_number_value = BASE_62_CHARACTERS.index(character)
        base_10_number_result += (base ** iterator_digit_pos) * residue_number_value
        iterator_digit_pos += 1
      end
      base_10_number_result
    end
  end
end