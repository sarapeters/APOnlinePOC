require './content_loader'
require './specialization'
require './calculations'
require './sum_calculation'
require './data_calculation'

module AccountsProduction
  class ContentLoader
    def block name
      puts "Loading content block #{name}..."
      filename = resolve_template name
      puts "Resolved to template #{filename}"
      self.load filename
    end

    def resolve_template name
      locations = [ "templates", name ]
      AccountsProduction::Specialization.source.each_pair do |k,v|
        locations << v
      end
      searched_paths = []
      temp = locations.clone
      while temp.size > 1 do
        path = temp.join "/"
        path += "/default.ap"
        searched_paths << path
        puts "Attempting path #{path}..."
        return path if File.exists? path
        path = temp.join "/"
        path += ".ap"
        puts "Attempting path #{path}..."
        return path if File.exists? path
        temp.pop
      end
      puts "Unable to find template after searching in the following locations:"
      searched_paths.each do |p|
        puts p
      end
    end

    def load filename
      template = File.read(filename)
      ERB.new(template).result(binding)
    end

    def content
      self
    end
 
    def sum_of *args
      s = AccountsProduction::SumCalculation.new self
      args.each { |arg| s.items << arg  }
      %Q{<span title="#{s.formula}">#{s.result}</span>}
    end

    def data_for key
      s = AccountsProduction::DataCalculation.new self
      s.items << key
      %Q{<span title="#{s.formula}">#{s.result}</span>}
    end

    def calc
      @calculator ||= AccountsProduction::Calculations.new
    end

    def data key
      AccountsProduction::Data.source[key.to_s]
    end

    def specialization key
      AccountsProduction::Specialization.source[key.to_s]
    end

    def director_pronoun
      directors = AccountsProduction::Data.source.select { |key, value| key.to_s.match(/^director\d+/) }
      return "We" unless directors.length == 1
      "I"
    end
  end
end

