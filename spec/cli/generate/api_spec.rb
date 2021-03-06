require 'spec_helper'
require 'napa/cli/generate/api'

describe Napa::CLI::Generate do
  let(:test_api_directory) { 'spec/tmp' }

  silence_thor

  before do
    allow_any_instance_of(described_class).to receive(:output_directory).and_return(test_api_directory)
  end

  after do
    FileUtils.rm_rf(test_api_directory)
  end

  describe 'foo api' do
    before do
      Napa::CLI::Generate.new.api('foo')
    end

    describe 'app' do
      describe 'apis' do
        before do
          expected_api_file = File.join(test_api_directory, 'app/apis/foos_api.rb')
          @api_code = File.read(expected_api_file)
        end

        it 'creates an api class' do
          expect(@api_code).to match(/class FoosApi/)
        end

        it 'describes a list action' do
          expect(@api_code).to match(/Get a list of foos/)
        end

        it 'describes a create action' do
          expect(@api_code).to match(/Create a foo/)
        end

        it 'describes a get action' do
          expect(@api_code).to match(/Get a foo/)
        end

        it 'describes an update action' do
          expect(@api_code).to match(/Update a foo/)
        end
      end

      it 'creates a representer class' do
        expected_representer_file = File.join(test_api_directory, 'app/representers/foo_representer.rb')
        representer_code = File.read(expected_representer_file)

        expect(representer_code).to match(/class FooRepresenter/)
      end

      it 'representers should inherit from Napa::Representer' do
        representer_file = File.join(test_api_directory, 'app/representers/foo_representer.rb')
        require "./#{representer_file}"
        expect(FooRepresenter.superclass).to be(Napa::Representer)
      end
    end

    describe 'spec' do
      it 'creates an api spec' do
        expected_api_file = File.join(test_api_directory, 'spec/apis/foos_api_spec.rb')
        api_code = File.read(expected_api_file)

        expect(api_code).to match(/describe FoosApi/)
      end
    end
  end

  # Uses the 'an' indefinite article.
  describe 'hour api' do
    before do
      Napa::CLI::Generate.new.api('hour')
    end

    describe 'app' do
      describe 'apis' do
        before do
          expected_api_file = File.join(test_api_directory, 'app/apis/hours_api.rb')
          @api_code = File.read(expected_api_file)
        end

        it 'creates an api class' do
          expect(@api_code).to match(/class HoursApi/)
        end

        it 'describes a list action' do
          expect(@api_code).to match(/Get a list of hours/)
        end

        it 'describes a create action' do
          expect(@api_code).to match(/Create an hour/)
        end

        it 'describes a get action' do
          expect(@api_code).to match(/Get an hour/)
        end

        it 'describes an update action' do
          expect(@api_code).to match(/Update an hour/)
        end
      end

      it 'creates a representer class' do
        expected_representer_file = File.join(test_api_directory, 'app/representers/hour_representer.rb')
        representer_code = File.read(expected_representer_file)

        expect(representer_code).to match(/class HourRepresenter/)
      end

      it 'representers should inherit from Napa::Representer' do
        representer_file = File.join(test_api_directory, 'app/representers/hour_representer.rb')
        require "./#{representer_file}"
        expect(FooRepresenter.superclass).to be(Napa::Representer)
      end
    end

    describe 'spec' do
      it 'creates an api spec' do
        expected_api_file = File.join(test_api_directory, 'spec/apis/hours_api_spec.rb')
        api_code = File.read(expected_api_file)

        expect(api_code).to match(/describe HoursApi/)
      end
    end
  end

end
