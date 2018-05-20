require 'travis'

name_and_repo = 'ItinoseSan/twi-Java'

# credential value
github_api_token = 'API-TOKEN'
# API Authentication
Travis.github_auth(github_api_token)

sync_repository = Travis::Repository.find(name_and_repo)
p sync_repository.last_build_state
