require 'spec_helper'

describe Kazoo::Conference do
  before do
    Kazoo::Auth.any_instance.should_receive(:token).any_number_of_times.and_return('valid-token')
    @auth = Kazoo::Auth.new
    @phone_numbers = ['+14151112222']
  end

  subject {Kazoo::Conference.new(@auth)}
  specify {subject.auth.should eq @auth}

  describe '#create_callflow' do
    it 'should return an error if phone numbers are not array' do
      pending
    end

    it 'should create a new call flow' do
      expected_response = {"auth_token" => @auth.token,
                           "status" => "success",
                           "data" => {"numbers" => @phone_numbers,
                                      "flow" => {"module" => "conference",
                                                 "data" => {},
                                                 "children" => {}},
                                      "id" => "ae16f443d8ce3a5b70716d0dbd4d0fc2"},
                           "revision" => "1-eda087bf61f19b37dab1cc14404c7034"}

      stub_request(:put, "http://api.2600hz.com:8000/v1/accounts/#{@auth.account_id}/callflows").
          with(:headers => {'Accept' => '*/*', 'User-Agent' => 'Ruby', 'Content-Type' => 'application/json'},
               :body => {:data => {:numbers => @phone_numbers, :flow => {:module => "conference", :data => {}, :children => {}}}, :auth_token => @auth.token}).
          to_return(:body => expected_response.to_json)

      subject.create_callflow(@phone_numbers).should eq expected_response
    end

    context 'and fails' do
      it 'should return error'
    end
  end
end