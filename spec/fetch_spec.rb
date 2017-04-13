require 'fetch'

RSpec.describe Fetch do

  describe "fetch method" do
    it "fetch course" do
      instance_fetch = Fetch.new
      fetched_course = instance_fetch.fetch('https://sdw-wsrest.ecb.europa.eu/service/data/EXR' +
        '/D.USD.EUR.SP00.A?detail=dataonly&startPeriod=2017-01-12&endPeriod=2017-01-12')

      expect(fetched_course).not_to be_empty
    end


    it "doesn't fetch data if non-existent date" do
      begin
        instance_fetch = Fetch.new
        fetched_course = instance_fetch.fetch('https://sdw-wsrest.ecb.europa.eu/service/data/EXR' +
          '/D.USD.EUR.SP00.A?detail=dataonly&startPeriod=2217-04-12&endPeriod=2217-04-12')
      rescue SystemExit=>e
        expect(e.status).to eq(0)
      end
      #Should see on the screen message "Course of the typed date is absent on the site"
    end
  end
end
