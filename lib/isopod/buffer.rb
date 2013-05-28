class Isopod::IO

  class Buffer 
    TOKEN_WHITESPACE=[0x00, 0x09, 0x0A, 0x0C, 0x0D, 0x20]

    # some strings for comparissons. Declaring them here avoids creating new
    # strings that need GC over and over
    LEFT_PAREN = "("
    LESS_THAN = "<"
    STREAM = "stream"
    ID = "ID"
    FWD_SLASH = "/"

    attr_reader :pos, :tokens

    def initialize(io)
      @io = io
      @tokens = []
    end
    
    def peek
      token(:peek=>true)
    end


    def token(*args)
      options = args.extract_options!
      tok = ""
      # read until tne next whitespace solidus or eol marker
      @pos = @io.pos if options[:peek] == true
      while !TOKEN_WHITESPACE.include?(byte = @io.getbyte)
        tok << byte
      end
      @io.seek @pos, IO::SEEK_SET if options[:peek] == true
    end
    
    def clear 
      @tokens.clear
    end

    def tokens(count)
      count.times do |i|
        @tokens << token
      end
      @tokens
    end

    def read(bytes)
      @io.read(bytes)
    end    

  end

end
