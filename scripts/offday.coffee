offdays = [
  '2015-12-30',
  '2015-12-31',
  '2016-01-01',
	'2016-01-02',
	'2016-01-03',
]

pad = (n) ->
	str = n.toString()
	return (if str.length < 2 then '0' else '') + str

format = (date) ->
	return date.getFullYear() + '-' + pad(date.getMonth() + 1) + '-' + pad(date.getDate())

module.exports =
	isOffday: (date) ->
		format(date) in offdays
