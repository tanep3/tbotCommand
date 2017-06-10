apiUrl = "https://api.apigw.smt.docomo.ne.jp/dialogue/v1/dialogue"
apikey = "?APIKEY=ご自分のAPIキー"
url = apiUrl + apikey

module.exports = (robot) ->
	robot.respond(/ねぇ(.*)/i, (msg) ->
		sentence = msg.match[1]
		#encSentence = encodeURIComponent(sentence)
		postJSONdata = JSON.stringify {
			"utt":"#{sentence}"
			,"context":"tbotzatsudan"
			}
		#console.log(postJSONdata)
		request = robot.http(url)
			.header("Content-type", "application/json")
			.post(postJSONdata)
		request((err, res, body) ->
			if err
				msg.send("なんかエラーが起きました。")
				return
			result = JSON.parse(body)
			#console.log result
			msg.send result.utt
		)
	)
