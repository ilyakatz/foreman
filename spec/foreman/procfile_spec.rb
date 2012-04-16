require 'spec_helper'
require 'foreman/process'
require 'foreman/procfile'

describe "read procfile" do

  it "should read procfile" do
    write_procfile

    procfile = Foreman::Procfile.new("Procfile")

    procs = procfile.send(:parse_procfile, "Procfile")

    procs.size.should == 2
    procs.first.name.should == "alpha"
    procs.first.command.should == "./alpha"

    procs.last.name.should == "bravo"
    procs.last.command.should == "./bravo"

  end

  describe "should write advanced procfile" do

    it "should read development correctly" do
      write_advanced_procfile

      procfile = Foreman::Procfile.new("Procfile")

      procs = procfile.send(:parse_procfile, "Procfile", :slice=>"development")

      procs.size.should == 2
      procs.first.name.should == "alpha_dev"
      procs.first.command.should == "./alpha"

      procs.last.name.should == "bravo_dev"
      procs.last.command.should == "./bravo dev"
    end

    it "should read test correctly" do
      write_advanced_procfile

      procfile = Foreman::Procfile.new("Procfile")

      procs = procfile.send(:parse_procfile, "Procfile", :slice=>"test")

      procs.size.should == 2
      procs.first.name.should == "alpha_test"
      procs.first.command.should == "./alpha"

      procs.last.name.should == "bravo_test"
      procs.last.command.should == "bundle exec rake resque:work QUEUE=* &"
    end

  end
end