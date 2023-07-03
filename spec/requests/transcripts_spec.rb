require 'rails_helper'

RSpec.describe "Transcripts", type: :request do

  describe '#translate' do
    context 'when audio does not contain flagged words' do
      it 'renders success message with status 200' do
        allow(controller).to receive(:convert_audio_to_text).and_return('Sample transcript')
        allow(controller).to receive(:analyze_text).and_return('Analyzed text')
        allow(controller).to receive(:check_flagged_words).and_return([])

        post "/translate", params: { audio_file: 'C:\Users\karan\Documents\ruby\Parse_Audio\files\JaiShriRam.mp3' }

        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq({ 'message' => 'Parsed audio successfully.' })
      end
    end
  end
end
