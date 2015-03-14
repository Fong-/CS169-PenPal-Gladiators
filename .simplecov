require "codeclimate-test-reporter"

SimpleCov.start 'rails' do
    formatter SimpleCov::Formatter::MultiFormatter[
        SimpleCov::Formatter::HTMLFormatter,
        CodeClimate::TestReporter::Formatter
    ]
end
