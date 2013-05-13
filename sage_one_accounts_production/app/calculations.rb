module AccountsProduction
  class Calculations
    def sum(*args)
      args.inject(:+)
    end

    def round(value, places)
      value.round places
    end
  end
end
