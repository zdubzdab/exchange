require 'csv'
require 'open-uri'
require './lib/save'

class Fetch
  def fetch(*url)
    if url == []
      File.truncate('./courses.yml', 0) if File.file?('./courses.yml')
      csv_text = open(
        "https://sdw-wsrest.ecb.europa.eu/service/data/EXR/D.USD.EUR.SP00.A?detail=dataonly",
        "Accept" => "text/csv")
      csv = CSV.parse(csv_text, headers: true)
      p "Please wait a few minutes"
      instance_save = Save.new
      instance_save.save_to_db(csv)
    else
      csv_text = open(url.first, "Accept" => "text/csv")
      csv = CSV.parse(csv_text, headers: true)
      check_if_date_exist_in_site(csv)
    end
  end

  private

  def check_if_date_exist_in_site(csv)
    if csv.first == nil
      p 'Course of the typed date is absent on the site'
      exit
    else
      instance_save = Save.new
      instance_save.save_to_db(csv)
      p instance_save.save_to_db(csv)
    end
  end
end
