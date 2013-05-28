class Isopod::XrefTable
  def initialize(*args)
    options               = args.extract_options!
    @buffer             ||= options[:buffer]
    @offset             ||= options[:offset]
    @sub_sections         = []
    @start		  = nil
    @count		  = nil
    load
  end

  def load
    @buffer.seek(@offset)
    return nil if !@buffer.token.include?("xref")
    load_sub_sections
  end

  def load_sub_sections
    # next two tokens are start_index and count
    @start, @count = @buffer.tokens(2)
    @count.times do |i|
      @sub_sections << XrefSubsection.new(@buffer)
    end 
    
  end

end

