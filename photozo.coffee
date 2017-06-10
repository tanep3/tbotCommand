
module.exports = (robot) ->
	robot.respond(/(.*)の写真/i, (msg) ->
		apiUrl = "https://api.photozou.jp/rest/search_public.json?limit=5&keyword="
		keyWord = msg.match[1]
		enckeyword = encodeURIComponent(keyWord)
		apiUrl += keyWord
		#console.log apiUrl
		request = robot.http(apiUrl)
			.get()
		request((err, res, body) ->
			if err
				msg.send("なんかエラーが起きました。\n"+err)
				return
			data = JSON.parse(body)
			#console.log(data)
			if data.info.photo_num==0
				msg.send("写真が見つかりませんでした；；")
				return
			respond = ""
			#console.log(data.info.photo[0])
			for i in data.info.photo
				#console.log(i.original_image_url+":\n")
				#respond += i.thumbnail_image_url
				respond += i.original_image_url
				respond += "\n"
			msg.send(respond+"おわり")
		)
	)
