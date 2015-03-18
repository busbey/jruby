require File.expand_path('../../../../spec_helper', __FILE__)
require File.expand_path('../../fixtures/common', __FILE__)

describe "Logger::LogDevice#close" do
  before :each do
    @file_path = tmp("test_log.log")
    @log_file = File.open(@file_path, "w+")

    # Avoid testing this with STDERR, we don't want to be closing that.
    @device = Logger::LogDevice.new(@log_file)
  end

  after :each do
    @log_file.close unless @log_file.closed?
    rm_r @file_path
  end

  ruby_version_is "" ... "1.9" do
    it "closes the LogDevice's stream" do
      @device.close
      lambda { @device.write("Test") }.should raise_error
    end

    it "raises an error if it's already closed" do
      @device.close
      lambda { @device.close }.should raise_error
    end
  end

  ruby_version_is "1.9" do
    it "closes the LogDevice's stream" do
      @device.close
      lambda { @device.write("Test") }.should complain(/\Alog writing failed\./)
    end
  end

end
