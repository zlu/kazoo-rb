require 'spec_helper'

describe Kazoo::Conference do
  before do
    Kazoo::Auth.any_instance.should_receive(:token).any_number_of_times.and_return('valid-token')
    @auth = Kazoo::Auth.new(kazoo_config)
    @phone_numbers = ['+14151112222']
    @name = 'my super duper conference'
    @conference_numbers = ['1234']
  end

  subject { Kazoo::Conference.new(@auth) }
  specify { subject.auth.should eq @auth }

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

  describe '#create_room' do
    context 'and succeeds' do
      it 'should create a new conference room' do
        expected_response =
            {"auth_token" => "555555c8d6f213098729999999999999",
             "status" => "success",
             "data" => {"name" => @name,
                        "conference_numbers" => @conference_numbers,
                        "member" => {"pins" => [], "numbers" => [], "play_name" => false, "join_muted" => true, "join_deaf" => false},
                        "moderator" => {"pins" => [], "numbers" => [], "play_name" => false, "join_muted" => true, "join_deaf" => false},
                        "require_moderator" => false,
                        "wait_for_moderator" => true,
                        "max_members" => 15,
                        "id" => "5eb2aac8d6f21309872920aedccbf885"},
             "revision" => "1-d832f5497369796e1e0f0482584678ee"}

        stub_request(:put, "http://api.2600hz.com:8000/v1/accounts/#{@auth.account_id}/conferences").
            with(:headers => {'Accept' => '*/*', 'User-Agent' => 'Ruby', 'Content-Type' => 'application/json'},
                 :body => {:data => {:name => @name, :conference_numbers => @conference_numbers}, :auth_token => @auth.token}).
            to_return(:body => expected_response.to_json)

        subject.create_room(@name, @conference_numbers).should eq expected_response
      end
    end

    context 'and fails' do
      it 'should return with error for conference numbers not in array' do
        pending
      end
    end
  end
end