require "active_support/core_ext/string"

module CapitalizeAttributes
  class SelectiveCapitalizer
    ABBREVIATION_MAX_LENGTH = 4
    ABBREVIATION_VOWELS = %w(a e i o u y).freeze
    ROMAN_NUMERALS = %w(i ii iii iv v vi vii viii ix x).to_set.freeze
    ALWAYS_DOWNCASED_WORDS = [
      "de",
      "of",
      "on",
      "the",
    ].to_set.freeze

    def self.perform(value)
      words = value.split
      words.map { |word| capitalize(word) }.join(" ")
    end

    def self.capitalize(word)
      # Modify the word only if it is all lowercase or all uppercase.
      # This avoids inadvertently capitalizing names intended to have mixed
      # case, like "McDonald".
      #
      # If a word is mixed case, we assume the person entering it
      # intends the case to be as entered.
      return word unless word.downcase == word || word.upcase == word

      downcased_word = word.downcase

      case
      when always_downcased?(downcased_word)
        downcased_word
      when abbreviation?(downcased_word)
        word.upcase
      when roman_numeral?(downcased_word)
        word.upcase
      else
        word.titleize
      end
    end

    def self.abbreviation?(downcased_word)
      return false if downcased_word.length > ABBREVIATION_MAX_LENGTH

      chars = downcased_word.chars
      (chars - ABBREVIATION_VOWELS) == chars
    end

    def self.roman_numeral?(downcased_word)
      ROMAN_NUMERALS.include?(downcased_word)
    end

    def self.always_downcased?(downcased_word)
      ALWAYS_DOWNCASED_WORDS.include?(downcased_word)
    end
  end
end
