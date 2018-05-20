require 'sinatra/base'
require 'sinatra'
require 'travis'

post "/webhook" do
  travis = TravisCIStatus.new
  name_and_repo = ENV['NAME_AND_REPO_NAME']
  send_message = travis.status_message(name_and_repo)
  payload = {
      followupEvent:{
          name: :"WEBHOOK_RECEIVED",
          data:{
              build_status: :"#{send_message}"
          }
      }
  }
  body payload.to_json
end

get "/" do
  "Hello, This is webhook application for dialogflow"
end

class TravisCIStatus
  def status_message(name_and_repo)
    api_token = ENV['GITHUB_API_TOKEN']
    Travis.github_auth(api_token)
    sync_repository = Travis::Repository.find(name_and_repo)
    build_status = sync_repository.last_build_state
    build_duration = sync_repository.last_build_duration
    sync_repository_name = sync_repository.slug

    message_maker = MessageMaker.new
    message_maker.make_response_message(build_status, build_duration,sync_repository_name)
  end
end

class MessageMaker
  def make_response_message(status, duration, name)
    case status
      when'passed'
        "同期してるリポジトリ、#{name}のビルドは成功しています。ビルド実行時間は#{duration}です。"
      when 'failed'
        "同期してるリポジトリ、#{name}のビルドは失敗しています。
　　　 詳しくはログをtravis-ci上で確認してください。ビルド実行時間は#{duration}です。"
      else
        "リポジトリのビルド状態を確認出来ませんでした。"
    end
  end
end
