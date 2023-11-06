# frozen_string_literal: true

class SynonymsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :validate_admin_user, except: [:show]

  # Lists all unapproved synonyms for admin review
  def index
    synonyms = Synonym.where(approved: false)
    render json: synonyms
  end

  # Approve a synonym suggestion
  def approve
    synonym = Synonym.find(params[:id])
    synonym.approved = true
    if synonym.save
      render json: synonym
    else
      render json: synonym.errors, status: :unprocessable_entity
    end
  end

  def destroy
    synonym = Synonym.find(params[:id])
    synonym.destroy
    head :no_content
  end

  private

  def validate_admin_user
    render json: { error: 'Not Authorized' }, status: 401 unless current_user.admin?
  end
  
end
