require 'sinatra/base'
require 'sinatra'
require './travis_build'

post "/tell_build" do
  status 200
  travis = TravisBuild.new('GITHUB ACCESS TOKEN')
  build_status = travis.show_build_status("ItinoseSan/twi-Java")

  if build_status == 'passed'
    @message = 'buildが成功しました'
  elsif build_status == 'failed'
    @message = 'buildが失敗しました'
  end
  body = "{\"simpleRespone\":\"#{@message}\"}"

  request.body.rewind
  events = JSON.parse(body)
  events.each{|event|
    logger.info JSON.generate(event)
  }
  if body == ''
    status 400
  else
    body.to_json
  end
end

get "/" do
    "Hello, This is webhook application for dialogflow"
end

