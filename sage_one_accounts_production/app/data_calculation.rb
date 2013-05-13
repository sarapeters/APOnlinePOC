module AccountsProduction
  class DataCalculation
    attr_reader :items, :data_provider

    def initialize data_provider
      @data_provider = data_provider
      @items = []
    end

    def formula
      "=#{items.first}"
    end

    def result
      data_provider.data(items.first)
    end
  end
end
