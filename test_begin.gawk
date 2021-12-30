BEGIN{
	print "Hello World"	
}

{
	print $0
}

END{
	print "That`s all"

}
