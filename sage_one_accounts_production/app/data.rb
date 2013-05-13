require 'yaml'

module AccountsProduction
  module Data
    def self.source
      @source
    end

    def self.source= source
      @source = source
    end
  end
end

filename = 'test_data.yaml'
AccountsProduction::Data.source = YAML.load_file(filename)

puts "Loading #{filename}..."
