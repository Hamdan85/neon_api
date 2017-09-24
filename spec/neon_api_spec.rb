require "spec_helper"

RSpec.describe NeonApi do
  it "has a version number" do
    expect(NeonApi::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
