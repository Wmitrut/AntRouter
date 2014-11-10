RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  # config.excluded_models += [Address]

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app


    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model Address do
    edit do
      field :latitude, :map do
        default_zoom_level 16
        map_width 600
        default_latitude -26.072171
        default_longitude -53.038692
      end
    end
  end

end
