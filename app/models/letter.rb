class Letter < ActiveRecord::Base

  has_many :comments, ->{ order("likes_count desc") }, dependent: :destroy

  validates :url, format: URI::regexp(%w(http https))

  scope :with_better_letters, ->{ where(created_at: [1.days.ago..Time.now], comments_count: 1..Float::INFINITY).order("comments_count desc").first(5) }
  scope :classify_letters, ->(category){ where(category: category).order("created_at desc") }

  def self.select_categories
    categories = Hash.new
    keys = ["テクノロジー", "ビジネス", "政治・経済", "金融・マーケット", "キャリア・教育", "スポーツ", "イノベーション"]

    keys.each do |key|
      categories["#{key}"] = self.where(created_at: [7.day.ago..Time.now], comments_count: 1..Float::INFINITY, category: key).order(comments_count: :desc, created_at: :desc).first(3)
    end
    categories
  end

  def created_in_24hours?
    now = Time.now
    if (now - 24 * 60 * 60) <= self.created_at.time && self.created_at.time <= now
      true
    else
      nil
    end
  end

  def created_time
    d = self.created_at
    "#{d.year}年#{d.month}月#{d.day}日"
  end

  def best_five_comments
    comments.first(5)
  end

  def user_comment(user)
    comments.find_by(user_id: user.id)
  end

  def max_like_user
    comment = comments.order("likes_count desc").first(1)[0]
    if comment.nil?
      nil
    else
      User.find(comment.user_id)
    end
  end

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
    if letter[:description].present?
      description = letter[:description]
      letter[:category], letter[:confidence] = watson_api(description)
    end
    self.update(letter)
  end

  private
    def watson_api(text)
      uri = URI.parse("https://gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers/#{ENV['NLC_CLASSIFIER_ID']}/classify")
      params = { text: text }
      uri.query = URI.encode_www_form(params)

      request = Net::HTTP::Get.new(uri)
      request.basic_auth( ENV['NLC_USERNAME'], ENV['NLC_PASSWORD'])

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https"){|http|
        http.request(request);
      }

      obj = JSON.parse(response.body)
      return obj["top_class"], (obj["classes"][0]["confidence"])
    end
end
