require 'course_store'

RSpec.describe CourseStore do

  describe "save method" do
    it "save course" do
      course = Course.new
      course.key = 'EXR.D.USD.EUR.SP00.A'
      course.freq = 'D'
      course.currency = 'USD'
      course.currency_denom = 'EUR'
      course.exr_type = 'SP00'
      course.exr_suffix = 'A'
      course.time_period = '2017-04-12'
      course.obs_value = '1.0605'
      store = CourseStore.new('courses.yml')
      saved_course = store.save(course)

      expect(saved_course.key).to eq ('EXR.D.USD.EUR.SP00.A')
      expect(saved_course.freq).to eq ('D')
      expect(saved_course.currency).to eq ('USD')
      expect(saved_course.currency_denom).to eq ('EUR')
      expect(saved_course.exr_type).to eq ('SP00')
      expect(saved_course.exr_suffix).to eq ('A')
      expect(saved_course.time_period).to eq ('2017-04-12')
      expect(saved_course.obs_value).to eq ('1.0605')
    end

    it "save course" do
      store = CourseStore.new('courses.yml')
      desired_course = store.find_by_date('2017-04-12')

      expect(desired_course.time_period).to eq ('2017-04-12')
    end
  end
end
