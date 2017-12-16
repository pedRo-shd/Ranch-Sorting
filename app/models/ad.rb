class Ad < ActiveRecord::Base

  # Constants
  QT_PAGE_PER = 6

  # RatyRate gem
  ratyrate_rateable 'quality'

  # Callbacks Markdown gem Redcarpet
  before_save :md_to_html

  # Associações
  belongs_to :category, counter_cache: true
  belongs_to :member
  has_many :comments
  # Validates
  validates :title, :description_md, :description_short, :category, :finish_date, :picture, presence: true
  validates :price, numericality: { greater_than: 0 }

  # gem money-rails
  monetize :price_cents

  scope :to_the, -> (member) { where(member: member) }
  scope :descending_order, -> (page) { order(created_at: :desc).page(page).per(QT_PAGE_PER) }
  scope :by_category, -> (id, page) { where(category: id).page(page).per(QT_PAGE_PER) }
  scope :search, -> (term, page) { where("lower(title) LIKE ?", "%#{term.downcase}%").page(page).per(QT_PAGE_PER)}
  scope :random, ->(quantity) { limit(quantity).order("RANDOM()") }
  
  # méthod paperclip, picture is name by column in table Ad
  has_attached_file :picture, styles: { large: "800x300#", medium: "320x150#",
                                        thumb: "100x100>" },
                                        default_url: "/images/:style/missing.png"

  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  # Markdown gem Redcarpet
  # Para saber mais, ver doc no github
  def md_to_html
   options = {
     filter_html: true,
     link_attributes: {
       rel: "nofollow",
       target: "_blank"
     }
   }
   extensions = {
     space_after_headers: true,
     autolink: true
   }
   renderer = Redcarpet::Render::HTML.new(options)
   markdown = Redcarpet::Markdown.new(renderer, extensions)
   self.description = markdown.render(self.description_md)
  end
end
