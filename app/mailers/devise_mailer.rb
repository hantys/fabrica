# lib/devise_backgrounder.rb

# Mailer proxy to send devise emails in the background
class DeviseMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer'

  before_action :add_inline_attachment!

  def confirmation_instructions(record, token, opts = {})
    super
  end

  def reset_password_instructions(record, token, opts = {})
    super
  end

  def unlock_instructions(record, token, opts = {})
    super
  end

  private
  def add_inline_attachment!
    attachments.inline['logo-rua-alecrim.png'] = File.read(File.join(Rails.root,
      'app','assets','images','mail','logo-rua-alecrim.png'))
    attachments.inline['bg-01.jpg'] = File.read(File.join(Rails.root,
      'app','assets','images','mail','bg-01.jpg'))
    attachments.inline['instagram.png'] = File.read(File.join(Rails.root,
      'app','assets','images','mail', 'social-icons', 'instagram.png'))
    attachments.inline['facebook.png'] = File.read(File.join(Rails.root,
      'app','assets','images','mail', 'social-icons', 'facebook.png'))
  end

end