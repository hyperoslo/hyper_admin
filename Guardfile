guard :rspec, cmd: 'bundle exec rspec spec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb')       { 'spec' }
  watch(%r{^spec/support/(.+)\.rb$}) { 'spec' }

  watch(%r{^app/(.+)\.rb$})                        { |match| "spec/#{match[1]}_spec.rb" }
  watch(%r{^app/(.*)\.erb$})                       { |match| "spec/#{match[1]}#{match[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_controller\.rb$}) { |match| "spec/controllers/#{match[1]}_controller_spec.rb" }

  watch('app/controllers/application_controller.rb') { 'spec/controllers' }
end

