require './lib/course_store'
require './lib/fetch'

class Exchanger
  def exchange(number, date)
    if date.kind_of?(Array)
      date.map { |each_date| p count_exchanged_money(number, each_date)}
    else
      p count_exchanged_money(number, date)
    end
  end

  private

  def count_exchanged_money(number, date)
    (get_course(date) * number).round(2)
  end

  def get_course(date)
    if get_course_from_db(date)
      get_course_from_db(date).obs_value.to_f
    else
      get_course_from_site(date)
    end
  end

  def get_course_from_db(date)
    store = CourseStore.new('courses.yml')
    if date.kind_of?(String)
      store.find_by_date(date)
    else
      store.find_by_date(date.strftime('%Y-' '%m-' '%d'))
    end
  end

  def get_course_from_site(date)
    instance_fetch = Fetch.new
    instance_fetch.fetch(create_url(date))
    get_course(date)
  end

  def create_url(date)
    'https://sdw-wsrest.ecb.europa.eu/service/data/EXR/D.USD.EUR.SP00.A?detail=dataonly' +
    '&startPeriod=' + convert_date_to_desired_format(date) + '&endPeriod=' + 
    convert_date_to_desired_format(date)
  end

  def convert_date_to_desired_format(date)
    if date.kind_of?(String)
      date
    else
      date.strftime('%Y-' '%m-' '%d')
    end
  end
end
