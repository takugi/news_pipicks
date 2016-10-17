class Letter < ActiveRecord::Base

  scope :user_letter, ->(user) { where(id: user.comments.select(:letter_id).distinct) }

  has_many :comments, dependent: :destroy

  validates :url, format: URI::regexp(%w(http https))

  def user_comment(user)
    self.comments.find_by(user_id: user.id)
  end

  def max_like_comment_user
    comment = self.comments.order("likes_count desc").first(1)[0]
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

    self.update(title: letter[:title], image: letter[:image], site_name: letter[:site_name], description: letter[:description])
  end
end
