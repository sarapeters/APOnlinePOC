module AccountsProduction
  class SumCalculation
    attr_reader :items, :data_provider

    def initialize data_provider
      @data_provider = data_provider
      @items = []
    end

    def formula
      components = items.join(', ')
      "=SUM(#{components})"
    end

    def result
      total = 0
      items.each { |i| total += data_provider.data(i) }
      total
    end
  end
end
