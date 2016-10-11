class Letter < ActiveRecord::Base

  has_many :comments

  validates :url, format: URI::regexp(%w(http https))

  def create_letter
    agent = Mechanize.new
    page = agent.get(self.url)
    elements = page.search('meta')

    letter = {}

    elements.each do |ele|
      property = ele.get_attribute(:property)
      if property == "og:title"
        letter[:title] = ele.get_attribute(:content)
      elsif property == "og:image"
        letter[:image] = ele.get_attribute(:content)
      elsif property == "og:site_name"
        letter[:site_name] = ele.get_attribute(:content)
      elsif property == "og:description"
        letter[:description] = ele.get_attribute(:content)
      end
    end

    self.update(title: letter[:title], image: letter[:image], site_name: letter[:site_name], description: letter[:description])
  end
end
