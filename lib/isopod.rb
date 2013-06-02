class Array
  def extract_options!
    last.is_a?(::Hash) ? pop : {}
  end unless defined? Array.new.extract_options!
end

class Isopod
  def self.hi(language="english")
    translator = Translator.new(language)
    translator.hi
    
  end

  def self.trailer io
   trailer = Trailer.new
   trailer.parse io
  end
end

require 'isopod/translator'
require 'isopod/trailer'
require 'isopod/buffer'
require 'isopod/document'
