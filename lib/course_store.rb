require 'yaml/store'
require './lib/course'

class CourseStore
  def initialize(file_name)
    @store = YAML::Store.new(file_name)
  end

  def save(course)
    @store.transaction do
      unless course.id
        highest_id = @store.roots.max || 0
        course.id = highest_id + 1
      end
      @store[course.id] = course
    end
  end

  def find_by_date(desired_date)
    @store.transaction do
      get_date(desired_date)
    end
  end

  private

  def get_date(desired_date)
    @store.roots.each do |id|
      return @store[id] if compare_date(desired_date, @store[id].time_period)
    end
    return false
  end

  def compare_date(desired_date, cur_date)
    desired_date.eql? cur_date
  end
end
