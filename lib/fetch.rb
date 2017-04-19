require 'csv'
require 'open-uri'
require './lib/save'

class Fetch
  def fetch(url = 'url', saving_class = Save)
    if url == 'url'
      remove_db_if_it_exist
      fetch_data(saving_class)
    else
      csv_text = open(url, "Accept" => "text/csv")
      csv = CSV.parse(csv_text, headers: true)
      check_if_date_exist_in_site(csv)
    end
  end

  private

  def remove_db_if_it_exist
    File.truncate('./courses.yml', 0) if File.file?('./courses.yml')
  end

  def fetch_data(saving_class)
    csv_text = open(
      "https://sdw-wsrest.ecb.europa.eu/service/data/EXR/D.USD.EUR.SP00.A?detail=dataonly",
      "Accept" => "text/csv")
    csv = CSV.parse(csv_text, headers: true)
    p "Please wait a few minutes"
    instance_save = saving_class.new
    instance_save.save_to_db(csv)
  end

  def check_if_date_exist_in_site(csv, saving_class = Save)
    if csv.first == nil
      p 'Course of the typed date is absent on the site'
      exit
    else
      instance_save = saving_class.new
      instance_save.save_to_db(csv)
    end
  end
end
