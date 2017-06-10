apiUrl = "https://ja.wikipedia.org/w/api.php?action=query&format=json&prop=extracts&redirects=1&exchars=200&explaintext=1"

module.exports = (robot) ->
	robot.respond(/wiki (.*)/i, (msg) ->
		title = msg.match[1]
		encTitle = encodeURIComponent(title)
		request = robot.http(apiUrl)
			.query(titles: title)
			.get()

		request((err, res, body) ->
			if err
				msg.send("なんかエラーが起きました...")
				return

			data = JSON.parse(body)
			for id, value of data.query.pages
				if value.extract?
					respond = "Wikipediaによりますと！\n"
					respond += "https://ja.wikipedia.org/wiki/"
					respond += title
					respond += "\n"
					respond += value.extract
					msg.send(respond)
				else
					msg.send("すみません、Wikipediaにありませんでした...")
		)
	)
