class Isopod::XrefTable
  def initialize(*args)
    options               = args.extract_options!
    @io                 ||= options[:io]
    @offset             ||= options[:offset]
    @sub_sections         = []
    load
  end

  def load
    @io.seek(@offset, IO::SEEK_SET)
    keyword = @io.readline
    puts keyword
    return nil if !keyword.include?("xref")
    load_sub_sections
  end

  def load_sub_sections
    sub_section = XrefSubSection.new(@io)
    while !sub_section.empty?
      @sub_sections << sub_section
      sub_section = XrefSubSection.new(@io)
    end

  end

end

