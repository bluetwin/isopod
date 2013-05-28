class Isopod::TrailerDictionary < Isopod::Dictionary
  attr_reader :dict, :size, :prev, :root, :encrypt, :info, :id, :xref_stm

  def initialize(io)
    pos = io.pos
    parse
    io.seek pos, IO::SEEK_SET
  end

  def parse(io)
    
  end


end
