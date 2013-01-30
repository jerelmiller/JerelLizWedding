class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    storage: :dropbox,
                    dropbox_credentials: "#{Rails.root}/config/dropbox.yml",
                    styles: { :content => '800>', :thumb => '118x100#' },
                    dropbox_options: {
                      path: proc { |style| "#{Rails.env}/ckeditor/pictures/#{style}/#{id}/#{data.original_filename}"}
                    }

  validates_attachment_size :data, :less_than => 2.megabytes
  validates_attachment_presence :data

  def url_content
    url(:content)
  end
end
