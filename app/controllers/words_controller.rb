# frozen_string_literal: true

class WordsController < ApplicationController
  def synonyms
    word = Word.find_by(text: params[:text])
    if word
      render json: word.synonyms.where(approved: true)
    else
      render json: { message: 'Word not found' }, status: :not_found
    end
  end

  private

  def synonym_params
    params.require(:synonym).permit(:text)
  end
end