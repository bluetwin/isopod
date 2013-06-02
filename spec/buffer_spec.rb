require 'spec_helper'

describe Isopod::Buffer do 
  it "should return PDF header" do
    buf = Isopod::Buffer.new(File.open("/home/brandon/code-projects/isopod/sample.pdf"))
    buf.token.should == "%PDF-1.4"
  end
  
  it "should parse three tokens" do
    buf = Isopod::Buffer.new(File.open("/home/brandon/code-projects/isopod/sample.pdf","r"))
    buf.tokens(3).should == ["%PDF-1.4", "1", "0"]
  end

  it "should parse tokens in reverse direction" do
    io = File.open("/home/brandon/code-projects/isopod/sample.pdf","r")
    io.seek 0, IO::SEEK_END
    buf = Isopod::Buffer.new(io)
    buf.token(:reverse=>true).should == "%%EOF"
  end

  it "should parse an object" do
    io = File.open("/home/brandon/code-projects/isopod/sample.pdf","r")
    io.seek 9, IO::SEEK_SET
    buf = Isopod::Buffer.new(io)
    buf.tokens(3)
    buf.object.class.to_s.should == "Object"

  end

end
