require 'terminal-table'

module Usermanagecli
  module Format
    class Table
      def initialize
        @@table = Terminal::Table.new :headings => %w(id username name admin supervisor csr)
      end

      def format(user)
        row = []
        row << user["id"]
        row << user["username"]
        row << user["name"]
        row << (user["admin"] ? "*" : "")
        row << (user["supervisor"] ? "*" : "")
        row << (user["csr"] ? "*" : "")
        @@table << row
      end

      def to_s
        @@table.to_s
      end
    end
  end
end
