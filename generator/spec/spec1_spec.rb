require File.dirname(__FILE__) + '/spec_helper'

describe "spec1" do

  it "app name should be" do
    App.name.should be_an_instance_of(String)    
  end

end