class Members::SessionsController < Devise::SessionsController

  def new
    super do |resource|
      resource.build_profile_member
    end
  end


  protected
  # Redireciona member a este path após logar, método customizado do devise,
  # para mais detalhes ver documentação Devise Redirect:
  # https://github.com/plataformatec/devise/wiki/How-To:-redirect-to-a-specific-page-on-successful-sign-in
    def after_sign_in_path_for(resource)
      stored_location = stored_location_for(resource)

      if stored_location.match(site_ad_details_path)
        stored_location
      else
        site_profile_dashboard_index_path
      end
    end

    # def after_update_path_for(resource)
    #   signed_in_root_path(resource)
    # end
end
