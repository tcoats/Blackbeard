String::contains = (it) ->
	@indexOf(it) != -1

String::caseInsensitiveContains = (it) ->
	@toUpperCase().contains it.toUpperCase()

String::toTitleCase = () ->
	@replace /([\w&`'‘’"“.@:\/\{\(\[<>_]+-? *)/g, (match, p1, index, title) ->
		if (index > 0 and title.charAt(index - 2) != ":" and match.search(/^(a(nd?|s|t)?|b(ut|y)|en|for|i[fn]|o[fnr]|t(he|o)|vs?\.?|via)[ \-]/i) > -1)
			match.toLowerCase()
		else if (title.substring(index - 1, index + 1).search(/['"_{(\[]/) > -1)
			match.charAt(0) + match.charAt(1).toUpperCase() + match.substr(2)
		else if (match.substr(1).search(/[A-Z]+|&|[\w]+[._][\w]+/) > -1 or title.substring(index - 1, index + 1).search(/[\])}]/) > -1)
			match
		else
			match.charAt(0).toUpperCase() + match.substr(1)

# http://stackoverflow.com/questions/105034/how-to-create-a-guid-uuid-in-javascript
window.S4 = () ->
	(((1+Math.random())*0x10000)|0).toString(16).substring(1)
window.guid = () ->
	(S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4())

(($) ->
	$.extend $, {
		markdown: () ->
			strip: (markdown) ->
				markdown
					.replace(
						/(\[[a-zA-Z ][^\]]*\])/g,
						(match, p1, index, title) ->
							match.substr(1, match.length - 2))
					.replace(
						/(\[[0-9]*\])/g,
						(match, p1, index, title) -> '')
					.replace(/\*\*\[\*\*/, '')
					.replace(/\*\*\]\*\*/, '')
					.replace(/\*\*\*\*/, '')
			list: (markdown) ->
				# remove blank lines
				# prefix every new line with *
				result = []
				chunks = content.split '\n'
				$.each chunks, (key, value) ->
					if value == ''
						return
					result.push('* ' + value)
				return result.join('\n')
		linkify: (html, linkify) ->
			if (!linkify)
				linkify = (url) ->
					'<a href="' + url + '">' + url + '</a>'
			html.replace /(?:http|ftp|https):\/\/[\w\-_]+(?:\.[\w\-_]+)+(?:[\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&amp;/~\+#])/g, (match, index) ->
				# skip anything inside an HTML tag
				# skip anything already inside an anchor tag
				if ((html.lastIndexOf('>', index) < html.lastIndexOf('<', index)) or (html.lastIndexOf('</a>', index) < html.lastIndexOf('<a ', index)))
					return match
				linkify(match)
		linkifyWord: (html, word, linkify) ->
			if (!linkify)
				linkify = (url, text) ->
					"<a href=\"#" + (url.replace " ", "+") + "\">" + text + "</a>"
			result = ''
			lowerCaseword = word.toLowerCase()
			
			while (html.length > 0)
				i = html.toLowerCase().indexOf(lowerCaseword, i);
				if (i < 0)
					return result + html;
		
				# should we skip?
				# skip if there is a letter before
				# skip if there is a letter afterwards
				# skip anything inside an HTML tag
				# skip anything already inside an anchor tag
				if ((i > 0 && /^[a-zA-Z]$/.test(html[i - 1])) or (i + word.length < html.length && /^[a-zA-Z]$/.test(html[i + lowerCaseword.length])) or (html.lastIndexOf('>', i) < html.lastIndexOf('<', i)) or (html.lastIndexOf('</a>', i) < html.lastIndexOf('<a ', i)))
					i++
					continue
				
				# add the part that didn't, match plus our new content
				result += html.substring(0, i) + linkify(word, html.substr(i, word.length))
		
				# we don't have to look at that part of the html
				html = html.substr(i + word.length)
				i = 0
			
			result
		linkifyWiki: (html, pages, linkify) ->
			newPages = _.clone pages
			# sort by string length, longer ones at the start
			newPages.sort (x, y) ->
				if (x.length < y.length)
					1
				else if (x.length > y.length)
					-1
				else 0
			# this means we are matching the longest articles first, 
			# so we will get the most complete match
			_.each newPages, (page) ->
				html = $.linkifyWord(html, page, linkify)
			
			html
	}
)(jQuery)