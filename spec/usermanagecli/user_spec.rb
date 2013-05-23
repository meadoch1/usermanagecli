require 'spec_helper'

module Usermanagecli
    
  describe User do
#    let(:url) { "http://foo.com" }
    let(:url) { "http://localhost:3000" }
    describe 'list_users' do
      context "with no results returned" do
        it do
          RestClient.should_receive(:get).with("#{url}/users.json").and_return("[]")
          User.list_users(url).should ==
            """+----+----------+------+-------+------------+-----+
| id | username | name | admin | supervisor | csr |
+----+----------+------+-------+------------+-----+
+----+----------+------+-------+------------+-----+"""
        end
      end
      
      
      context "with an array of two users" do
        let(:result) { '[{"id":1,"username":"user1","name":"User One","admin":true,"supervisor":null, "csr":null},{"id":2,"username":"user2","name":"User Two","admin":null,"supervisor":true,"csr":true}]' }

        it do
          RestClient.should_receive(:get).with("#{url}/users.json").and_return(result)
          User.list_users(url).should ==
            """+----+----------+----------+-------+------------+-----+
| id | username | name     | admin | supervisor | csr |
+----+----------+----------+-------+------------+-----+
| 1  | user1    | User One | *     |            |     |
| 2  | user2    | User Two |       | *          | *   |
+----+----------+----------+-------+------------+-----+"""
        end
      end
    end

    let(:user_id) { 1 }
    describe 'set_role' do
      context "setting a single role value" do
        let(:role_args) { ["admin:true"] }
        it do
          RestClient::Request.should_receive(:execute).with(:method => :put, :url => "#{url}/users/#{user_id}.json", :payload => "{\"id\":1,\"admin\":\"1\"}", :headers => {:content_type => 'application/json'})
          User.set_roles(url, user_id, role_args).should == "Role(s) successfully updated"
        end
        
      end
      context "setting a multiple role values" do
        let(:role_args) { ["admin:true", "csr:false"] }
        it do
          RestClient::Request.should_receive(:execute).with(:method => :put, :url => "#{url}/users/#{user_id}.json", :payload => "{\"id\":1,\"admin\":\"1\",\"csr\":\"0\"}", :headers => {:content_type => 'application/json'})
          User.set_roles(url, user_id, role_args).should == "Role(s) successfully updated"
        end
      end
    
      context "setting a bad role value" do
        let(:role_args) { ["foo:true"] }
        it do
          STDERR.should_receive(:puts).with("Error: The only valid roles are admin, supervisor, or csr")
          lambda { User.set_roles url, user_id, role_args  }.should raise_error SystemExit
        end
      end
    end

    describe 'set_password' do
      let(:passwd) {"newpass"}
      context "setting with matching passwords" do
        let(:confirm) {passwd}
        it do
          RestClient::Request.should_receive(:execute).with(:method => :put, :url => "#{url}/users/#{user_id}/password.json", :payload => "{\"id\":1,\"password\":\"newpass\",\"password_confirmation\":\"newpass\"}", :headers => {:content_type => 'application/json'})
          User.set_password(url, user_id, [passwd, confirm]).should == "Password successfully updated"
        end
        
      end
      context "setting with mismatched passwords" do
        let(:confirm) {"badpass"}
        it do
          STDERR.should_receive(:puts).with("Error: The password and confirmation password did not match")
          lambda { User.set_password url, user_id, [passwd, confirm] }.should raise_error SystemExit
        end
        
      end
      context "setting with missing confirmation" do
        it do
          STDERR.should_receive(:puts).with("Error: You must supply both a password and a confirmation password which match")
          lambda { User.set_password url, user_id, [passwd] }.should raise_error SystemExit
        end
        
      end
      
    end
    
  end
end
