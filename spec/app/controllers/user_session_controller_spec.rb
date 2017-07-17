require 'spec_helper'

RSpec.describe "/user_session" do
  pending "add some examples to #{__FILE__}" do
    before do
      get "/user_session"
    end

    it "returns hello world" do
      expect(last_response.body).to eq "Hello World"
    end
  end
end
