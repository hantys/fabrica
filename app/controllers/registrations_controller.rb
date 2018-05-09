# app/controllers/users/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  # DELETE /resource
  def destroy
    resource.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    flash[:danger] = I18n.t("#{:devise}.#{:registrations}.#{:destroyed}") if is_navigational_format?
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end
end