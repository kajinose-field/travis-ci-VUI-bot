# travis-ci-VUI-bot
The voice user interface bot application that tell build status of sync repository on travis-ci.

![untitled](https://user-images.githubusercontent.com/24353841/40277570-da75b652-5c5b-11e8-960e-ceec7ae97de5.png)

# Set up
## Repository side
first, clone this repository
```
git clone https://github.com/kajinose-field/travis-ci-VUI-bot
```
install dependencies
```
bundle install 
```
export enviroment variable that use in app.rb
```bash
export GITHUB_API_TOKEN=xxxxx...
export NAME_AND_REPO_NAME=your_github_name/your_repository_name
```
### publish webhook

start the webhook on local
```
bundle exec ruby app.rb
```
way to easy publish
```
./ngrok http 4567 
```
sinatra default port is 4567. If you want to change this, use ```-p <PORT>``` flag

If you dont use ngrok to publish webhook, you should deploy to the cloud server(required SSL)

## Dialogflow side
create the two intent

intent name format. ```.Response``` is easy to check kind of intent
```
HogeIntent
HogeIntent.Response
```
### HogeIntent Settings
Input some training phrases

![screenshot from 2018-05-20 17-11-17](https://user-images.githubusercontent.com/24353841/40276942-faaa0a78-5c50-11e8-9a92-cfc1103e111d.png)

In this time, no problem in ```Responses``` content is empty.

After that, enable webhook in fulfillment.

![screenshot from 2018-05-20 17-15-44](https://user-images.githubusercontent.com/24353841/40276962-865549b6-5c51-11e8-946f-50996a814e9c.png)
### HogeIntent.Response Settings
Make a event which name is WEBHOOK_RECEIVED

![screenshot from 2018-05-20 17-22-10](https://user-images.githubusercontent.com/24353841/40277003-6e1ae8d2-5c52-11e8-8ffa-7625d25b63d0.png)

Set parameter ```build_status```
![screenshot from 2018-05-20 17-24-44](https://user-images.githubusercontent.com/24353841/40277021-d81ed072-5c52-11e8-9ba8-a91a33e3382a.png)

Input ```$build_status``` to ```Responses``` of DEFAULT and GOOGLE ASISTANT

### fulfillment
Set the random url which is made by ngrok

![screenshot from 2018-05-20 17-32-37](https://user-images.githubusercontent.com/24353841/40277072-ec7b5f58-5c53-11e8-9f00-5f241ed8c21c.png)

All settins finished. you can quickly try talking on chat on dialogflow console
