require 'spec_helper'

describe Kazoo::Auth do
  before do
    @auth_token = "eca9233822a03ef9da0adf207db64d48"
    stub_request(:put, "http://api.2600hz.com:8000/v1/api_auth").
        with(:headers => {'Accept' => '*/*', 'User-Agent' => 'Ruby', 'Content-Type' => 'application/json'},
             :body => {:data => {:api_key => /.*/}}).
        to_return(:body => {"auth_token" => @auth_token,
                            "status" => "success",
                            "data" => {"account_id" => "my_test_account_id"}}.to_json)

    subject { Kazoo::Auth.new }
  end


  describe '#initialize' do
    specify { subject.api_key.length.should eq 64 }
    specify { subject.host.should eq 'api.2600hz.com' }
    specify { subject.port.should eq '8000' }
    specify { subject.version.should eq 'v1' }
    specify { subject.account_id.length.should eq 32 }
    specify { subject.token.length.should eq 32 }
  end

  describe '#get_token' do
    context 'where there is not an existing auth token' do
      specify { subject.get_token.should eq @auth_token }
      specify { subject.get_token.length.should eq 32 }
    end

    context 'when there is an auth token' do
      it 'should not make request if auth_token exists' do
        auth = Kazoo::Auth.new
        auth.should_receive(:token).and_return("a valid auth token")
        Nestful.should_not_receive(:put)
        auth.get_token
      end
    end
  end
end
