require "spec_helper"

RSpec.describe NeonApi do
  it "has a version number" do
    expect(NeonApi::VERSION).not_to be nil
  end
end
