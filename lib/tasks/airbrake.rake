desc 'notify airbrake on deploy'
task airbrake_deployments: :environment do
  require 'airbrake/rake/tasks'
  Rake::Task['airbrake:deploy'].invoke
end
