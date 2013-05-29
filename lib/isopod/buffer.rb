class Isopod::Buffer 
    TOKEN_WHITESPACE=[0x00, 0x09, 0x0A, 0x0C, 0x0D, 0x20]

    # some strings for comparissons. Declaring them here avoids creating new
    # strings that need GC over and over
    LEFT_PAREN = "("
    LESS_THAN = "<"
    STREAM = "stream"
    ENDSTREAM = "endstram"
    ID = "ID"
    FWD_SLASH = "/"

    attr_reader :pos, :tokens

    def initialize(io)
      @io = io
      @tokens = []
    end
    
    def clear 
      @tokens.clear
    end
    
    def peek
      tok = ""
      @pos = @io.pos
      tok = token
      @io.seek @pos, IO::SEEK_SET
      tok
    end

    def read(bytes)
      @io.read(bytes)
    end    

    def seek(bytes, type)
      @io.seek(bytes, type)
    end

    def token(*args)
      options       = args.extract_options!
      reverse	  ||= options[:reverse]
      tok 	    = ""
      # read until tne next whitespace solidus or eol marker
      # TODO: Check for EOF
      @io.seek -2, IO::SEEK_CUR if reverse
      while !TOKEN_WHITESPACE.include?(byte = @io.getbyte)
        tok << byte
        @io.seek -2, IO::SEEK_CUR if reverse
      end
      (reverse ? tok.reverse! : tok)
    end

    def tokens(*args)
      options       = args.extract_options!
      count         = options[:count].nil? ? args[0] : options[:count]
      reverse     ||= options[:reverse]

      count.times do |i| # TODO: check for EOF
        @tokens << token(:reverse=> reverse)
      end
      @tokens
    end



end
