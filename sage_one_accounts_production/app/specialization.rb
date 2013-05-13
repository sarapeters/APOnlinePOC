require 'yaml'

module AccountsProduction
  module Specialization
    def self.source
      @source
    end

    def self.source= source
      @source = source
    end
  end
end

filename = 'test_specialization.yaml'
AccountsProduction::Specialization.source = YAML.load_file(filename)

puts "Loading #{filename}..."
