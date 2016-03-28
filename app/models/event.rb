class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  belongs_to :owner, class_name: 'User'

  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  # scope :without_past, -> () {where }
  scope :owned_by, -> (owner_id) {where(owner_id: owner_id)}
  scope :published, -> {where(published: true)}
  scope :upcomming, -> {where("starts_at >= :start_date", {start_date: DateTime.now}).published}
  # scope :search, ->(search = '') {}

  def self.search(search = nil)

    if search.nil?
      upcomming
    else
      where("lower(name) like :search", {search: "%#{search.downcase}%"}).upcomming
    end

  end

  def available?
    starts_at >= DateTime.now
  end
end
