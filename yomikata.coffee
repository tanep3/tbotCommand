apiUrl = "https://labs.goo.ne.jp/api/hiragana"
appID = "ご自分のアプリID"

module.exports = (robot) ->
	robot.respond(/よみかた (.*)/i, (msg) ->
		sentence = msg.match[1]
		encSentence = encodeURIComponent(sentence)
		postJSONdata = JSON.stringify {"app_id":"#{appID}","sentence":"#{sentence}","output_type":"hiragana"}
		#console.log(postJSONdata)
		request = robot.http(apiUrl)
			.header("Content-type", "application/json")
			.post(postJSONdata)
		request((err, res, body) ->
			if err
				msg.send("なんかエラーが起きました。")
				return
			result = JSON.parse(body)
			#console.log result
			msg.send result.converted
		)
	)
