require 'save'

RSpec.describe Save do

  describe "save method" do
    it "save course" do
      csv_text = open('https://sdw-wsrest.ecb.europa.eu/service/data/EXR' +
        '/D.USD.EUR.SP00.A?detail=dataonly&startPeriod=2017-04-11&endPeriod=2017-04-11',
        "Accept" => "text/csv")
      csv = CSV.parse(csv_text, headers: true)
      instance_save = Save.new
      instance_save.save_to_db(csv)
      store = CourseStore.new('courses.yml')
      desired_course = store.find_by_date('2017-04-11')

      expect(desired_course.key).to eq ('EXR.D.USD.EUR.SP00.A')
      expect(desired_course.freq).to eq ('D')
      expect(desired_course.currency).to eq ('USD')
      expect(desired_course.currency_denom).to eq ('EUR')
      expect(desired_course.exr_type).to eq ('SP00')
      expect(desired_course.exr_suffix).to eq ('A')
      expect(desired_course.obs_value).to eq ('1.0616')
    end
  end
end
