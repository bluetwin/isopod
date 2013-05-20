
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
