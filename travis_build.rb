require 'travis'

class TravisBuild
  def initialize(token)
    @token = token
  end
  def show_build_status(name_and_repo)
    Travis.github_auth(@token)
    sync_repository = Travis::Repository.find(name_and_repo)
    sync_repository.last_build_state
  end
end