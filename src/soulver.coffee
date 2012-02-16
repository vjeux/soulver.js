
$ ->
	window.editor = editor = null
	window.editor = editor = CodeMirror.fromTextArea document.getElementById("code"),
		lineNumbers: true
		lineWrapping: true
		onUpdate: ->
			return if not editor

			$(rightbar).html ''
			for i in [0 ... editor.lineCount()]
				val = ''
				try
					val = parser.parse editor.getLine i
					val ?= ''
				catch e
					console.error e.message

				# This is a quick and dirty way to do it, but not optimized AT ALL :)
				$('<pre>')
					.html(val.toString())
					.height($('pre:nth-child(' + (i + 1) + ')', gutter).height())
					.appendTo(rightbar)

	wrapper = editor.getWrapperElement()

	$('.CodeMirror-lines > div', wrapper)
		.css('margin-right': 200)

	gutter = $('.CodeMirror-gutter', wrapper)

	rightbar_wrapper = $('<div>')
		.addClass('CodeMirror-rightbar')
		.appendTo($('.CodeMirror-gutter', wrapper).parent())

	rightbar = $('<div>')
		.addClass('CodeMirror-rightbar-text')
		.appendTo(rightbar_wrapper)

	editor.refresh()
