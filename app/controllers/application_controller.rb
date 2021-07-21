# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from RecordNotFound do |_exception|
    respond_to do |format|
      format.html { render file: Rails.root.join('public/404.html'), layout: 'layouts/application', status: :not_found }
      format.all { render nothing: true, status: :not_found }
    end
  end
end
