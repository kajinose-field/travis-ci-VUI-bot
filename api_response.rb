require './travis_build'

github_access_token = ENV['GITHUB_TOKEN']
name_and_repo = 'ItinoseSan/twi-Java'

repo_check = TravisBuild.new(github_access_token)
status = repo_check.show_build_status(name_and_repo)

if status == "passed"
  p "build:passing"
elsif status == "failed"
  p "build:failing"
else
  p "build:unknown"
end