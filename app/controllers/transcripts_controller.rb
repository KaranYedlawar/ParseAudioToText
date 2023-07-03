require 'httparty'
class TranscriptsController < ApplicationController

  def translate
    audio_file = params[:audio_file]

    transcript = convert_audio_to_text(audio_file)
    analyzed_text = analyze_text(transcript)
    flagged_words = check_flagged_words(analyzed_text)

    if flagged_words.empty?
      render json: { message: 'Parsed audio successfully.' }, status: :ok
    else
      render json: { message: 'Audio contains flagged words. User blocked.' }, status: :bad_request
    end
  end

  def show
    transcript_id = params[:id]
    transcript = Transcript.find_by(id: transcript_id)

    if transcript.nil?
      render json: 
    { message: 'Transcript not found.' 
    }, status: :not_found
    else
      render json: 
    { analyzed_text: transcript.transcript_text 
    }, status: 200
    end
  end

  
  private
  def convert_audio_to_text(audio_file)
    headers = {
      'authorization' => ENV['ASSEMBLYAI_API_TOKEN'],
      'content-type' => 'audio/mpeg/mo3'
    }
  
    response = HTTParty.post(ENV['ASSEMBLYAI_SPEECH_TO_TEXT_URL'], body: audio_file, headers: headers)
  
    if response.code == 201
      response['text']
    else
      nil
    end
  end

  def analyze_text(text)

    headers = {
      'authorization' => ENV['ASSEMBLYAI_API_KEY'],
      'content-type' => 'application/json'
    }
    request_body = {
      text: text
    }.to_json
    response = HTTParty.post(ENV['ASSEMBLYAI_NATURAL_LANGUAGE_URL'], body: request_body, headers: headers)

    response['nlp']
  end
  
  def check_flagged_words(analyzed_text)
    flagged_words = []
  
    unless analyzed_text.nil?
      flagged_words << 'flagged' if analyzed_text.downcase.include?('flagged')
    end
  
    flagged_words
  end
end
