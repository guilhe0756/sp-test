require 'log_parser'

describe LogParser do

  subject(:log_parser) { described_class.new }
  let(:file) { "./data/webserver.log" }

  describe '#parse' do
    context 'when given a .log file' do
      it 'returns an array with individual lines' do
        expect(log_parser.parse(file)).to be_an_instance_of(Array)
      end

      it 'shows only the page name in each line' do
        expect(log_parser.parse(file)[0]).to eq("/help_page/1")
      end
    end
  end

  describe '#count_visits' do
    context 'when given an array of visited pages' do
      it 'returns an array with the page and its number of visits' do
        log_parser.parse(file)
        expect(log_parser.count_visits).to include("/help_page/1"=>80)
      end
    end
  end

  # As a data analyst
  # so that I can organise my data
  # I want to be able to separate normal views from unique views
  describe '#find_unique' do
    context 'when given a hash of visits per page' do
      it 'returns an array with unique page views' do
        log_parser.parse(file)
        log_parser.count_visits
        expect(log_parser.find_unique).to include("/about/2"=>90)
      end
    end
  end
end
