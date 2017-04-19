require './lib/course'
require './lib/course_store'

class Save
  def save_to_db(csv, course_class = Course, storing_class = CourseStore)
    csv.each do |row|
      course = course_class.new
      course.key = row['KEY']
      course.freq = row['FREQ']
      course.currency = row['CURRENCY']
      course.currency_denom = row['CURRENCY_DENOM']
      course.exr_type = row['EXR_TYPE']
      course.exr_suffix = row['EXR_SUFFIX']
      course.time_period = row['TIME_PERIOD']
      course.obs_value = row['OBS_VALUE']

      store = storing_class.new('courses.yml')
      store.save(course)
    end
  end
end
