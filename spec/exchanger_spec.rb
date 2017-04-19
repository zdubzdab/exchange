require 'exchanger'

RSpec.describe Exchanger do

  describe "exchange method" do

    it "returns desire number" do
      money = Exchanger.new

      exchanged_money1 = money.exchange(10, ("1999-07-14"))
      exchanged_money2 = money.exchange(10, ("1999-07-16"))

      expect(exchanged_money1).to eq (10.17)
      expect(exchanged_money2).to eq (10.2)
    end

    it "returns desire numbers" do
      money = Exchanger.new

      exchanged_money = money.exchange(10, (["1999-07-14", "1999-07-16"]))

      expect(exchanged_money).to eq ([10.17, 10.2])
    end

    it "return desired message if non-existent date" do
      begin
        money = Exchanger.new
        message = money.exchange(10, ("3999-07-14"))
      rescue SystemExit=>e
        expect(e.status).to eq(0)
      end
      #Should see on the screen message "Course of the typed date is absent on the site"
    end
    
    it "return desired message if date is in wrong data type" do
      begin
        money = Exchanger.new
        message = money.exchange(10, (3999-07-14))
      rescue SystemExit=>e
        expect(e.status).to eq(0)
      end
      #Should see on the screen message "Date should be string or created with Date class"
    end

  end
end
