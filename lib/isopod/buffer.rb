require 'isopod/objects/object'
require 'isopod/objects/indirect_object'
require 'isopod/objects/string'
require 'isopod/objects/hex_string'
require 'isopod/objects/array'
require 'isopod/objects/dictionary'

class Isopod::Buffer 
    TOKEN_WHITESPACE=[0x00, 0x09, 0x0A, 0x0C, 0x0D, 0x20]
    OBJECT_IDENTIFER=[0x28, 0x29, 0x3c, 0x3e, 0x5b, 0x5d]
    # some strings for comparissons. Declaring them here avoids creating new
    # strings that need GC over and over
    LEFT_PAREN = "("
    LEFT_BRACKET = "["
    LESS_THAN = "<"
    STREAM = "stream"
    ENDSTREAM = "endstram"
    ID = "ID"
    FWD_SLASH = "/"

    attr_reader :pos, :tokens

    def initialize(io)
      @io = io
      @tokens = [] # Queue struc: FIFO
    end
    
    def clear 
      @tokens.clear
    end
    
    def peek(c=nil)
      tok = ""
      @pos = @io.pos
      tok = c ? tokens(c) : token
      @io.seek @pos, IO::SEEK_SET
      tok
    end

    def read(bytes)
      @io.read(bytes)
    end    

    def seek(bytes, type)
      @io.seek(bytes, type)
    end

    def object
      obj = nil
      puts "Buffer::peek : #{peek}"
      case peek
       when LEFT_PAREN	 
         Isopod::String.new(self)
       when LEFT_BRACKET 
         Isopod::Array.new(self)
       when LESS_THAN 	
        if peek(2).join.eq?(LESS_THAN*2) 
          obj = Isodod::Dictionary.new(self)
        else
          Isopod::HexString.new(self)
        end
       when STREAM
         Isopod::String.new(self)
       else
         nil
      end
      obj
    end

    # return the next token from the source. Returns a string if a token
    # is found, parser will break on object identifierts or whitespace
    #
    # Its best to define a token here:
    #   a token is a piece of the underlying @io stream which can be any of 
    #   the following:
    #    a literal : number, string, endcoded byte stream
    #    whitespace as defined in the PDF spec
    #    an object identifier (,[,<,<<
    # Handling of sub-objects shoudl be handled by the object created and 
    # it parser.
    # Strategy: consume until a white space is met, if an object identifier 
    #           is met, stop unless token is empty, then consume and stop


    def token(*args)
      options       = args.extract_options!
      reverse	  ||= options[:reverse]
      # read until tne next whitespace solidus or eol marker
      # TODO: Check for EOF
      tok = ""
      @io.seek -2, IO::SEEK_CUR if reverse
      while !TOKEN_WHITESPACE.include?(byte = @io.getbyte)
        add_token tok, byte
        token << byte
        @io.seek -2, IO::SEEK_CUR if reverse
      end
      (reverse ? token.reverse! : token)
    end
    
    def add_token
    

    def tokens(*args)
      options       = args.extract_options!
      count         = options[:count].nil? ? args[0].to_i : options[:count]
      reverse     ||= options[:reverse]

      count.times do |i| # TODO: check for EOF
        @tokens << token(:reverse=> reverse)
      end
      @tokens
    end



end
