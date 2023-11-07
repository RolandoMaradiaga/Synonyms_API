# frozen_string_literal: true

class SynonymsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :create]
  before_action :validate_admin_user, except: [:show, :create]

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

  def create
    word = Word.find(params[:word_id]) # Find the word to ensure it exists
    synonym = word.synonyms.build(synonym_params) # Build a new synonym associated with the word

    if synonym.save
      render json: synonym, status: :created
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

  def synonym_params
    params.require(:synonym).permit(:text, :word_id)
  end
  
end
