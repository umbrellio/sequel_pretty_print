# frozen_string_literal: true

module Sequel::Plugins::PrettyPrint
  module InstanceMethods
    # Mimics the ActiveRecord's implementation
    def pretty_print(pp)
      if method(:inspect).owner != Sequel::Model.instance_method(:inspect).owner
        return super
      end

      pp.object_address_group(self) do
        keys = self.class.columns.select { |name| @values.key?(name) || new? }
        keys = (keys + @values.keys).uniq

        pp.seplist(keys, proc { pp.text(",") }) do |key|
          pp.breakable(" ")

          pp.group(1) do
            pp.text(key.to_s)
            pp.text(":")
            pp.breakable
            pp.pp(self[key])
          end
        end
      end
    end
  end
end
