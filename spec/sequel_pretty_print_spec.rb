# frozen_string_literal: true

require_relative "spec_helper"
require "pp"
require "sqlite3"

DB = Sequel.sqlite

DB.create_table(:artists) do
  column :id, :integer
  column :name, :text
end

class Artist < Sequel::Model
  plugin :pretty_print
end

RSpec.describe "pretty_print plugin" do
  describe "new Artist instance" do
    specify do
      expect(Artist.new.pretty_inspect)
        .to match(/^#<Artist:\S+ id: nil, name: nil>$/)

      expect(Artist.new(name: "Elvis").pretty_inspect)
        .to match(/^#<Artist:\S+ id: nil, name: "Elvis">$/)
    end
  end

  describe "existing Artist instance" do
    before { Artist.create(name: "Freddy") }

    let(:instance) { Artist.select(:name, Sequel.as("Mercury", :lastname)).first }

    specify do
      expect(instance.pretty_inspect)
        .to match(/^#<Artist:\S+ name: "Freddy", lastname: "Mercury">$/)
    end
  end

  describe "model with custom inspect method defined" do
    before do
      def instance.inspect
        "FOO"
      end
    end

    let(:instance) { Artist.new }

    specify do
      expect(instance.pretty_inspect).to eq("FOO\n")
    end
  end
end
