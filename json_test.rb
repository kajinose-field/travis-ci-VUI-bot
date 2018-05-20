require 'json'

payload = {
    followupEvent:{
        name: :"WEBHOOK_RECEIVED", # consoleで定義したEvent名
        data:{
            build_status: :"わかんなーい!"
        }
    }
}
p payload.to_json

#=> {
#    "followupEvent":{
#        "name":"WEBHOOK_RECEIVED",
#        "data":{
#             "build_status":"わかんなーい！"
#       }
#     }
#   }