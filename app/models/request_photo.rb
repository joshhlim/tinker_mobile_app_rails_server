class RequestPhoto < ApplicationRecord
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => [/\Aimage/, 'application/octet-stream', 'image/jpg', 'image/png']
  #has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  #validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  before_post_process on: :create do
    puts "\n\nself"
    p self
    if self.image_content_type == 'application/octet-stream'
      self.image_content_type = "image/png"
      #mime_type = MIME::Types.type_for(media_file_name)
      #self.media_content_type = mime_type.first.to_s if mime_type.first
    end
  end
  belongs_to :request
  has_one :user, through: :request
  has_many :comments
end
