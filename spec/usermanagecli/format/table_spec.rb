require 'spec_helper'

module Usermanagecli
  module Format
    
    describe Table do

      let(:formatter) { Table.new }

      context "with no users" do
        it do
          formatter.to_s.should ==
            """+----+----------+------+-------+------------+-----+
| id | username | name | admin | supervisor | csr |
+----+----------+------+-------+------------+-----+
+----+----------+------+-------+------------+-----+"""
        end
      end
        
        
      context "with an array of two users" do
        let(:users) { [ {"id" => 1, "username" => "user1", "name" => "User One", "admin" => true, "supervisor" => nil, "csr" => nil},
                        {"id" => 2, "username" => "user2", "name" => "User Two", "admin" => false, "supervisor" => true, "csr" => true} ] }

        before :each do
          users.each do |user|
            formatter.format(user)
          end
        end

        it do
          formatter.to_s.should ==
            """+----+----------+----------+-------+------------+-----+
| id | username | name     | admin | supervisor | csr |
+----+----------+----------+-------+------------+-----+
| 1  | user1    | User One | *     |            |     |
| 2  | user2    | User Two |       | *          | *   |
+----+----------+----------+-------+------------+-----+"""
        end
        
      end
    end
  end
end
