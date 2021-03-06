class Spotlight::ExhibitsController < Spotlight::ApplicationController
  before_filter :authenticate_user!
  before_filter :default_exhibit
  include Blacklight::SolrHelper

  authorize_resource

  def edit
    @exhibit.contact_emails << "" unless @exhibit.contact_emails.present?
  end

  def update
    if @exhibit.update(exhibit_params)
      redirect_to main_app.root_path, notice: "The exhibit was saved."
    else
      render action: :edit
    end
  end

  protected

  def exhibit_params
    params.require(:exhibit).permit(
      :title,
      :subtitle,
      :description,
      contact_emails_attributes: [:email]
    )
  end

  def default_exhibit
    @exhibit = Spotlight::Exhibit.default
  end
end
