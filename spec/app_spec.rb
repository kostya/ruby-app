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

    it "proc in config" do
      App.config.proc_test.should == "bbbccc"
    end

    it "load config from file config/config.yml" do
      App.config.file.should == :yml
    end

    it "safe check parameter in config" do
      App.config.try(:file).should == :yml
      App.config.try(:file2).should == nil
    end

    it "should load extensions" do
      App.some_gem_method.should == "some gem method"
    end

    it "force set env" do
      App.env.should == 'test3'
      App.config.apps.size.should == 4
      App.config.apps.uniq.should == ['test3']
      App.config.bla.should == 12
    end

    it "ErrorMailer should wrap raise" do
      Model.new.raised_method # should not raise
    end
  end

end
