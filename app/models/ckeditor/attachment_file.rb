class Ckeditor::AttachmentFile < Ckeditor::Asset
  has_attached_file :data,
                    storage: :dropbox,
                    dropbox_credentials: "#{Rails.root}/config/dropbox.yml",
                    styles: { :content => '800>', :thumb => '118x100#' },
                    dropbox_options: {
                      path: proc { |style| "jerelandliz/#{Rails.env}/ckeditor_assets/attachments/#{style}/#{id}/#{data.original_filename}"}
                    }

  validates_attachment_size :data, :less_than => 100.megabytes
  validates_attachment_presence :data

  def url_thumb
    @url_thumb ||= Ckeditor::Utils.filethumb(filename)
  end
end
