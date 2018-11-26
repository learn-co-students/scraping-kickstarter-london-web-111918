# require libraries/modules here
require "nokogiri"
require "pry"

def create_project_hash

  html = File.read("fixtures/kickstarter.html")
  kickstarter = Nokogiri::HTML(html).css(".project")
  
  kickstarter.each_with_object({}) do |project, info_hash|
    info_hash[project.css(".bbcard_name a").text] = {
      :image_link => project.css(".projectphoto-little").attr("src").value,
      :description => project.css(".bbcard_blurb").text.strip,
      :location => project.css(".location-name").text,
      :percent_funded => project.css(".funded strong").text.gsub("%", "").to_i
    }
  end

end
