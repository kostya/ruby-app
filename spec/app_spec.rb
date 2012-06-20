require File.dirname(__FILE__) + '/spec_helper'

describe "RubyApp" do

  describe "test1" do
    before :all do
      require File.join(File.dirname(__FILE__), %w{test_app config environment})
    end
    
    it "should require in right order" do
      App.config.test_thing.should == [1,2,3,4]
    end
  
    it "should be name" do
      App.name.should == 'Test_app'
    end
  
    it "redefine configs" do
      App.config.some1.should == 1
      App.config.some2.should == 'bbb'
    end
    
    it "constant - no warnings about redefine" do
      App::BLA.should == 1
    end
    
    it "force set env" do
      App.env.should == 'test3'
      App.config.apps.size.should == 4
      App.config.apps.uniq.should == ['test3']
      App.config.bla.should == 12
    end                              
    
  end
  
end
